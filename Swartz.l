%{

#include <stdio.h>

%}
%option yylinenumber

%%


print				   {return PRINT;}
printchar                          {return PRINT_CHAR;}
return                             {return RETURN;}
exit				   {return EXIT;}
function 			   {return FUNC;}
endfunction			   {return END_FUNC;}
callfunction			   {return CALL_FUNC;}
int  				   {return INT;}
double			   	   {return DOUBLE;}
array				   {return ARRAY;}
char  			  	   {return CHAR;}
if				   {return IF;}
endif 				   {return ENDIF;}
then                               {return THEN;}
else                               {return ELSE;}
for				   {return FOR;}
endfor				   {return ENDFOR;}
do				   {return DO;}
while                              {return WHILE;}
endwhile                           {return ENDWHILE;}
true				   {return TRUE;}
false				   {return FALSE;}


\= 			{return EQUAL;}
\+ 			{return SUM;}
\- 			{return SUB;}
\/			{return DIV;}
\*			{return MULT;}
\== 		        {return ISEQUAL;} 
\!= 		        {return NOTEQUAL;}
\>                      {return GREATER;}
\>=                     {return GREATEROREQUAL;}
\<                      {return SMALLER;}
\<=                     {return SMALLEROREQUAL;}
\%  			{return MOD;}
\.			{return DOT;}
\:                      {return COLON;}
\; 			{return SEMICOLON;}
\{                      {return LEFTCURLYBRACKET;}
\}                      {return RIGHTCURLYBRACKET;}
\(  			{return LEFTBRACKET ;}
\) 			{return RIGHTBRACKET ;}
\[                      {return LEFTSQUAREBRACKET;}             
\]                      {return RIGHTSQUAREBRACKET;}
\&                      {return AND;}
\||                     {return OR;}

\*\/.*			{return COMMENTLINE;}

\".*\" 			{return STRING;}

[0-9]                   {return DIGIT;}
[0-9]+                  {yylval.num = atoi(yytext); return NUMBER;}
[a-zA-Z0-9]     	{yylval.CHARACTER = yytext[1]; return CHARACTER;} 
[a-zA-z]                {return LETTER;}
[a-zA-z]+([a-zA-z]*|[a-zA-z]*)	{yylval.id = yytext[0]; return NUM_IDENTIFIER;}
[a-zA-z]+([a-zA-z]*|[a-zA-z]*)\: {return NAME_FUNC;}

%%

int yywrap (void) {return 1;}

void yyerror( char *c){
	frintf(stderr, "%s  %d\n", c, yylinenumber);
}
