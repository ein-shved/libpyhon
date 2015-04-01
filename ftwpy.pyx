cimport ftwpy

__doc__ = 'Primitive ftwpy.h wrapper'

cpdef enum:
    FTW_F = 0,
    FTW_D = 1,
    FTW_DNR = 2,
    FTW_NS = 3,

cdef class Stat:
    cdef public ftwpy.dev_t st_dev
    cdef public ftwpy.ino_t st_ino
    cdef public ftwpy.mode_t st_mode
    cdef public ftwpy.nlink_t st_nlink
    cdef public ftwpy.uid_t st_uid
    cdef public ftwpy.gid_t st_gid
    cdef public ftwpy.dev_t st_rdev
    cdef public ftwpy.off_t st_size
    cdef public ftwpy.blksize_t st_blksize
    cdef public ftwpy.blkcnt_t st_blocks
    cdef public ftwpy.time_t st_atim
    cdef public ftwpy.time_t st_mtim
    cdef public ftwpy.time_t st_ctim

    cdef __cinit(self, const ftwpy.stat *sb):
        self.st_dev = sb.st_dev
        self.st_ino = sb.st_ino
        self.st_mode = sb.st_mode
        self.st_nlink = sb.st_nlink
        self.st_uid = sb.st_uid
        self.st_gid = sb.st_gid
        self.st_rdev = sb.st_rdev
        self.st_size = sb.st_size
        self.st_blksize = sb.st_blksize
        self.st_blocks = sb.st_blocks
        self.st_atim = sb.st_atim.tv_sec
        self.st_mtim = sb.st_mtim.tv_sec
        self.st_ctim = sb.st_ctim.tv_sec

cdef object __g_ftw__
cdef int __g_ftw_cb__ (const char *fpath, const stat *sb,
        int typeflag):
    global __g_ftw__
    s = Stat()
    s.__cinit(sb)
    ret = __g_ftw__.fn(fpath, s, typeflag)

cdef class FTW:
    def __init__(self, const char *path, int nopenfd = 1):
        self.path = path
        self.nopenfd = nopenfd

    def run(self):
        global __g_ftw__
        __g_ftw__ = self
        ftw (self.path, __g_ftw_cb__, self.nopenfd)
    def fn(self, fpath, stat, typeflag):
        pass
