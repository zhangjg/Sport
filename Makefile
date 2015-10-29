SCR=$(wildcard *.c)
OBJ=$(SCR:%.c=obj/%.o)
ALL= test $(OBJ)
test: $(OBJ) lua/liblua.a
	gcc -o $@ $^ -lm
lua/liblua.a:
	cd lua;make liblua.a
obj/%.o:%.c
	gcc -c $^ -o $@
.PYTHON: clean  rebuild obj

obj:
	if [ ! test -e obj ] then
	-mkdir obj
	fi
clean:
	-rm $(OBJ);
rebuild:clean test
