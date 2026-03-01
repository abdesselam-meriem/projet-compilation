%{
    #include<stdio.h>
    #include "syntax.tab.h"

    int err = 0;
    int nb_ligne = 1;
    int nb_colonne = 1;
%}

lettre    [a-zA-Z]
chiffre   [0-9]
IDF       {lettre}({lettre}|{chiffre}|_)*
CST_INT   {chiffre}+
CST_REEL  {chiffre}+"."{chiffre}+
CHAINE    \"[^\"]*\"

%%

"Declaration"  printf("MC_DECLARATION\t\t(ligne %d)\n", nb_ligne);
"Code"         printf("MC_CODE\t\t(ligne %d)\n", nb_ligne);
"END"          printf("MC_END\t\t(ligne %d)\n", nb_ligne);
"IF"           printf("MC_IF\t\t(ligne %d)\n", nb_ligne);
"Do"           printf("MC_DO\t\t(ligne %d)\n", nb_ligne);
"print"        printf("MC_PRINT\t\t(ligne %d)\n", nb_ligne);
"int"          printf("TYPE_INT\t\t(ligne %d)\n", nb_ligne);
"flot"         printf("TYPE_FLOT\t\t(ligne %d)\n", nb_ligne);

{CHAINE}       printf("CHAINE : %s\t\t(ligne %d)\n", yytext, nb_ligne);
{CST_REEL}     printf("CST_REEL : %s\t\t(ligne %d)\n", yytext, nb_ligne);
{CST_INT}      printf("CST_INT : %s\t\t(ligne %d)\n", yytext, nb_ligne);
{IDF}          printf("IDF : %s\t\t(ligne %d)\n", yytext, nb_ligne );

"<="           printf("OP_AFF\t\t(ligne %d)\n", nb_ligne);
">"            printf("OP_COMP_SUP\t\t(ligne %d)\n", nb_ligne);
"<"            printf("OP_COMP_INF\t\t(ligne %d)\n", nb_ligne);
">="           printf("OP_Comp_Sup_EQ\t\t(ligne %d)\n", nb_ligne);
"=="           printf("OP_EQUAL\t\t(ligne %d)\n", nb_ligne);
"!="           printf("OP_DIFF\t\t(ligne %d)\n", nb_ligne);
"+"            printf("OP_ADD\t\t(ligne %d)\n", nb_ligne);
"-"            printf("OP_SUB\t\t(ligne %d)\n", nb_ligne);
"*"            printf("OP_MUL\t\t(ligne %d)\n", nb_ligne);
"/"            printf("OP_DIV\t\t(ligne %d)\n", nb_ligne);

"{"            printf("ACCOLADE_OUV\t\t(ligne %d)\n", nb_ligne);
"}"            printf("ACCOLADE_FER\t\t(ligne %d)\n", nb_ligne);
"("            printf("PARENTHESE_OUV\t\t(ligne %d)\n", nb_ligne);
")"            printf("PARENTHESE_FER\t\t(ligne %d)\n", nb_ligne);
";"            printf("PVG\t\t(ligne %d)\n", nb_ligne);
","            printf("VIRGULE\t\t(ligne %d)\n", nb_ligne);
":"            printf("DEUX_POINTS\t\t(ligne %d)\n", nb_ligne);

[ \t]          {nb_colonne++;}
\n             {nb_ligne++;}
<<EOF>>        { printf("FIN_FICHIER\t\t(ligne %d)\n", nb_ligne); return 0; }
.              printf("erreur lexicale a la ligne %d\n", nb_ligne); err++;

%%


int yywrap() {
    return 1;
}