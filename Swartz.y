%{
void yyerror (char *s);
int yylex();

#include <stdio.h>   
#include <stdlib.h>
#include <ctype.h>

int symbols[52];
int symbolVal(char symbol);
void updateSymbolValue(char symbol, int val);

%}

%union {int num; char id; char CHARACTER}

%token PRINT
%token PRINT_CHAR
%token RETURN
%token EXIT
%token FUNC
%token END_FUNC
%token CALL_FUNC
%token INT
%token DOUBLE 
%token ARRAY
%token CHAR
%token IF
%token ENDIF
%token THEN
%token ELSE
%token FOR
%token ENDFOR
%token DO
%token WHILE
%token ENDWHILE
%token TRUE
%token FALSE

%token EQUAL
%token SUB
%token SUM
%token DIV
%token MULT
%token ISEQUAL
%token NOTEQUAL
%token GREATER
%token GREATEROREQUAL
%token SMALLER
%token SMALLEROREQUAL
%token MOD
%token DOT
%token COLON
%token SEMICOLON
%token LEFTCURLYBRACKET
%token RIGHTCURLYBRACKET
%token LEFTBRACKET
%token RIGHTBRACKET
%token LEFTSQUAREBRACKET
%token RIGHTSQUAREBRACKET
%token AND
%token OR

%token STRING
%token DIGIT
%token LETTER
%token <num> NUMBER
%token <id> NUM_IDENTIFIER
%token <char> CHARACTER

%type <id> list_statements statements assignment_statements array_statements array_elements logic_expressions if_statements while_statements expressions terms define_function_statements
%type <id> call_function_statements return_statements define_list_parameters list_parameters logic_operators operators commentlines 

%%


list_statements : statements SEMICOLON
		| list_statements statements SEMICOLON
		;

statements	: assignment_statements
		| array_statements
		| if_statements
		| while_statements
		| define_function_statements
		| call_function_statements
		| return_statements 
		| expressions
		;

assignment_statements 	: NUM_IDENTIFIER EQUAL expressions {updateSymbolValue($1,$3); }
       			| NUM_IDENTIFIER EQUAL logic_expressions {updateSymbolValue($1,$3); } 
			| NUM_IDENTIFIER EQUAL CHARACTER {updateSymbolValue($1,$3); }
       			;

array_statements	: ARRAY NUM_IDENTIFIER EQUAL LEFTBRACKET array_elements RIGHTBRACKET;

array_elements		: NUMBER
			| NUMBER LEFTSQUAREBRACKET array_elements RIGHTSQUAREBRACKET
			| NUMBER array_elements
			| NUM_IDENTIFIER
			| NUM_IDENTIFIER array_elements
        		;

logic_expressions	: terms
			| logic_expressions NOTEQUAL terms { if($1 != $3){$$ = TRUE;} }
			| logic_expressions ISEQUAL terms { if($1 != $3){$$ = TRUE;} }
			| logic_expressions GREATER terms { if($1 != $3){$$ = TRUE;} }
			| logic_expressions SMALLER terms { if($1 != $3){$$ = TRUE;} }
			| logic_expressions GREATEROREQUAL terms { if($1 != $3){$$ = TRUE;} }
			| logic_expressions SMALLEROREQUAL terms { if($1 != $3){$$ = TRUE;} }
			;

if_statements		: IF LEFTBRACKET  logic_expressions RIGHTBRACKET list_statements ELSE LEFTCURLYBRACKET  list_statements RIGHTCURLYBRACKET ENDIF {$$ = $3;}
			| IF LEFTBRACKET  logic_expressions RIGHTBRACKET list_statements ENDIF {$$ = $3;}
			;

while_statements	: WHILE LEFTBRACKET logic_expression RIGHTBRACKET LEFTCURLYBRACKET list_statements RIGHTCURLYBRACKET ENDWHILE  {$$ = $3;}
			;

expressions		: terms
			| expression SUM terms {$$ = $1 - $3;}
 			| expression SUB terms {$$ = $1 - $3;}
			| expression DIV terms {$$ = $1 - $3;}
			| expression MULT terms {$$ = $1 - $3;}
			;

terms			: NUMBER {$$ = $1;}
			| NUM_IDENTIFIER {$$ = SymbolVal($1);}
			| STRING
			| DIGIT
			| TRUE
			| FALSE
			;

define_function_statements	: FUNC NAME_FUNC LEFTBRACKET define_list_parameters RIGHTBRACKET LEFTCURLYBRACKET list_statements RIGHTCURLYBRACKET END_FUNC
				| FUNC NAME_FUNC LEFTBRACKET RIGHTBRACKET LEFTCURLYBRACKET list_statements RIGHTCURLYBRACKET END_FUNC
				;

call_function_statements	: CALL_FUNC PRINT LEFTBRACKET expressions RIGHTBRACKET {printf("Print... %d\n", $4);}
				| CALL_FUNC NAME_FUNC LEFTBRACKET RIGHTBRACKET 
				| CALL_FUNC NAME_FUNC LEFTBRACKET list_parameters RIGHTBRACKET 
				;

return statements 		: RETURN expressions
				| RETURN SEMICOLON
				;

define_list_parameters		: terms
				| terms define_list_parameters
				;

list_parameters			: terms
				| terms list_parameters
				;

logic_operators			: GREATER
				| GREATEROREQUAL
				| SMALLER
				| SMALLEROREQUAL
				| NOTEQUAL
				| ISEQUAL
				| AND
				| OR
				;

operators			: SUM
				| SUB
				| DIV
				| MULT
				| EQUAL
				;

commentlines			: COMMENTLINE
				;

%%   

#include "lex.yy.c"


int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

int symbolValue(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}
void updateSymbolValue(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

int main (void) {
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

