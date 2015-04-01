import ftwpy

class FTW_test(ftwpy.FTW):
    def __init__(self):
        ftwpy.FTW.__init__(self, ".")
    def fn(self, fpath, s, f):
        print fpath

f = FTW_test()
f.run()
