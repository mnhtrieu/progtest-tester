# Progtest tester

A simple tester created in bash to test the inputs with the reference output from the progtest.
Before using it, you probably want to make it executable. So run `chmod +x ./progtest.sh` before using it.

Usage:
```
./progtest.sh <SOURCE FILE> <FOLDER TO THE TESTs>
```

The tester expects the tests to have consistent names therefore it checks the input file to contain the string _in_ in the name which will be converted to _out_.

For example:
```
1_in --> 1_out
in_1 --> out_1
1_in_1 --> 1_out_1
```

