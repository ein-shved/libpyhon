CFLAGS+=-I/usr/include/python2.7 -g -O0 -Wall -Werror
LDLIBS+=-lpython2.7

GENERATED=str *.so woex woexp.c list ftwpy.c

all:	str repeat.so woex woexp.so list ftwpy.so

%.c:	%.pyx
	cython $< -o $@

%.so: %.c
	$(CC) $< $(CFLAGS) -o $@ -shared -fPIC $(LDFLAGS) $(LDLIBS)

clean:
	rm -f $(GENERATED) *.o

demo:	all
	./str qwert 1 3 4
	python testrepeat.py
	./woex
	python testwoexp.py
	python testftw.py

test:	all
	valgrind ./str qwert 1 3 4
	valgrind ./list qwert abc 3 5 1 3 4
	valgrind python testrepeat.py
	python -c 'import repeat; print dir(repeat); help(repeat)' | cat
	valgrind python testwoexp.py
	python -c 'import woexp; print dir(woexp); help(woexp)' | cat
	valgrind python testftw.py
	python -c 'import ftwpy; print dir(ftwpy); help(ftwpy)' | cat
