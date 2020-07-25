Programming  Languages : Lexical Analyzer and Yacc Parser
***********************************************************
SWARTZ PROGRAMMING LANGUAGE
***********************************************************
20150807002 Serafettin BAL
***********************************************************



1. DEFINITION OF SWARTZ PL
***************************

• In the Swartz Programming language; As with Java and Python programming languages, care was taken to 
use expressions that are easy to write and understand, and easy to understand by anyone. The concept
of if_statement, while-statement and form of logic expression are designed as in Java programming
language. The function structure of Swartz is more like the Python programming languages. 

• Data types such as string, digit, char, boolean, double, array are available in Swartz. Also, in Swartz, 
all operation and comparison symbols such as "=", "+", "-", "*", "/", "! =", "==", ">", "<", "> =", "<="
are included. All these symbols are available in the Swartz.l lex file for the Swartz programming
language and all these expressions are compiled in Swartz.y file.

• It takes a file with extension .swa. 

• It has if, endif, while, for, print, commentline, etc.

• Swartz is ran by running the makefile and giving it to myPL as input -----> make ./myPL < example.swa

• In this language where you can make operator comparisons and assignments, you can create your own 
functions, define function values, use these values and call the function created from other files.

• Extended Backus Normal Form of the language will be given in part 2.
 


2. EXTENDED BACKUS NORMAL FORM OF SWARTZ PL
********************************************

<list_statements>  ::=  <statements>  
  |  <list_statements> <statements> 

<statements>  ::=  <assignment_statements>
  |  <array_statements>
  |  <if_statements>
  |  <while_statements>
  |  <define_function_statements>
  |  <call_function_statements>
  |  <return_statements>
  |  <expressions>

<assignment_statements>  ::=  NUM_IDENTIFIER  ‘=’ <expressions> 
  |  NUM_IDENTIFIER ‘=’ <logic_expressions> 
  |  NUM_IDENTIFIER ‘=’ CHARACTER

<array_statements >  ::=  ARRAY NUM_IDENTIFIER ‘=’  ‘(’  <array_elements>  ‘)’

<array_elements>  ::=  NUMBER  
  |  NUMBER  <array_elements>  
  |  NUMBER LEFTSQUAREBRACKET <array_elements> RIGHTSQUAREBRACKET
  |  NUM_IDENTIFIER  
  |  NUM_IDENTIFIER  <array_elements>

<if_statements>  ::=  IF ‘(’ <logic_expressions> ‘)’ ‘:’ <list_statements> ELSE <list_statements> ENDIF
                    | IF ‘(’ <logic_expressions> ‘)’ ‘:’ <list_statements> ENDIF

<logic_expressions>  ::=  <terms>  | <logic_expressions> <logical_operators> <terms>
			
                            
<expressions>  ::=  <terms>  | <expressions> <operators> <terms>

<terms>  ::=  NUMBER  | NUM_IDENTIFIER  | STRING  | DIGIT |  TRUE  | FALSE

<while_statements>   ::=   WHILE ‘(’ <logic_expressions> ‘)’ ‘:’ <list_statements> ENDWHILE

<define_function_statements>   ::=   FUNC NAME_FUNC ‘(’ <define_list_parameters> ‘)’ <list_statements> END_FUNC 
  |  FUNC FUNCTION_NAME ‘(’ ‘)’ <list_statements> END_FUNC

<call_function_statements>  ::=   CALL_FUNC PRINT ‘(’ <expressions> ‘)’
  |   CALL_FUNC NAME_FUNC ‘(’  ‘)’
  |   CALL_FUNC NAME_FUNC ‘(’  <list_parameters>  ‘)’

return_statements  ::=  “RETURN” <expressions>  |  “RETURN”  ‘;’

<define_list_parameters>  ::=  <terms>  |  <terms> <define_list_parameters>

<list_parameters>  ::=  <terms>  |  <terms> <list_parameters>

<operators>  ::=  +  |  -  |  /  |   *  |  = 

<logic_operators>  ::  =  >  |  >=  |  <  |  <=  |  =!  |  ==  |  &&  |  ||

<commentlines> :: = */*
