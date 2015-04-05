from ftwpy import FTW, FTW_F
from mutagen.mp3 import EasyMP3 as MP3
import re
import os
import sys

def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc: # Python >2.5
        if exc.errno == os.errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise

class FTW_psp(FTW):
    def __init__(self, path=".", out=None):
        FTW.__init__(self,path)
        if not out:
            out="All"
        out+='.m3u8'
        out_path = path + "/PSP/PLAYLIST/MUSIC/"
        mkdir_p(out_path);
        self.out_path = out_path + out

    def run(self):
        self.out = open(self.out_path, "w");
        self.out.write(u'#EXTM3U\n')
        FTW.run(self)

    def fn(self, fpath, stat, typeflag):
        if not typeflag == FTW_F or not re.match('^.*.mp3$', fpath):
            return
        mp3 = MP3(fpath);
        extinf = u"".join(("#EXTINF:",
                        str(int(mp3.info.length)),", ",
                        mp3.tags['artist'][0], " - ",
                        mp3.tags['title'][0])).encode('utf-8').strip()
        path = fpath.replace(self.path, "", 1).replace("/","\\");
        if path[0] != '\\':
            path = '\\' + path
        self.out.write(extinf)
        self.out.write('\n')
        self.out.write(path)
        self.out.write('\n')

path = "."
out=None
if len(sys.argv) > 1:
    path = sys.argv[1]
if len(sys.argv) > 2:
    out = sys.argv[2]

psp = FTW_psp(path, out);
psp.run()
