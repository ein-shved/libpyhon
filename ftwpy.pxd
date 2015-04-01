from posix.types cimport dev_t, ino_t, mode_t, nlink_t, uid_t, gid_t, off_t, blksize_t, blkcnt_t, time_t

cdef extern from "time.h":
    cdef struct timespec "timespec":
        time_t tv_sec
        long   tv_nsec

cdef extern from "sys/stat.h":
    cdef struct stat "stat":
        dev_t st_dev
        ino_t st_ino
        mode_t st_mode
        nlink_t st_nlink
        uid_t st_uid
        gid_t st_gid
        dev_t st_rdev
        off_t st_size
        blksize_t st_blksize
        blkcnt_t st_blocks
        timespec st_atim
        timespec st_mtim
        timespec st_ctim

cdef extern from "ftw.h":
    int ftw(const char *dirpath,
            int (*fn) (const char *fpath, const stat *sb,
                       int typeflag),
            int nopenfd);
