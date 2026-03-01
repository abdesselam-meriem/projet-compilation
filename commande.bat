flex file1.l
bison -d syntax.y
gcc lex.yy.c syntax.tab.c -o file1.exe 
file1.exe <test.txt