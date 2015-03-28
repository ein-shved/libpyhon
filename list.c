#include <Python.h>

int main(int argc, char *argv[]) {
    PyObject *expr[3];
    int i, s, e, r;
    char *res;
    int list_len = argc - 4;

    if(list_len<0) {
        fprintf(stderr,
                "Usage: [<string>...] <start> <end> <repeat>\n\n"
                "Print list[start:end]*repeat\n");
        exit(0);
    }

    s = atoi(argv[argc - 3]);
    e = atoi(argv[argc - 2]);
    r = atoi(argv[argc - 1]);
    expr[0] = PyList_New(list_len);
    for (i=0; i<list_len; ++i) {
        PyList_SetItem(expr[0], i, PyString_FromString(argv[i+1]));
    }
    expr[1] = PySequence_GetSlice(expr[0], s, e);
    expr[2] = PySequence_Repeat(expr[1], r);
    printf("[ ");
    list_len = PySequence_Length(expr[2]);
    for (i=0; i<list_len; ++i) {
        res=PyString_AsString(PySequence_GetItem(expr[2], i));
        printf("'%s'",res);
        if (i < list_len - 1) {
            printf(", ");
        }
    }
    printf(" ]\n");

    for(i=0; i<3; i++) Py_CLEAR(expr[i]);
    return 0;
}
