import ftwpy

class FTW_test(ftwpy.FTW):
    def __init__(self):
        ftwpy.FTW.__init__(self, ".")
    def fn(self, fpath, s, f):
        if f == ftwpy.FTW_F:
            print "File", fpath
        elif f == ftwpy.FTW_D:
            print "Dir", fpath


f = FTW_test()
f.run()
