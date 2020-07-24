install:
	flex pLHardindestro.l
	gcc lex.yy.c -o Hardindestro.hrd -lfl
remove:
	rm Hardindestro.hrd
	rm lex.yy.c