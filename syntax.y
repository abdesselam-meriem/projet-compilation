%{
    #include <stdio.h>
    #include <stdlib.h>
    
    extern int nb_ligne;
    extern int nb_colonne;
    extern int yylex();
    void yyerror(const char *msg);
%}

%token MC_DECLARATION MC_CODE MC_END MC_IF MC_DO MC_PRINT
%token TYPE_int TYPE_flot
%token IDF CST_INT CST_REEL CHAINE
%token OP_AFF
%token OP_COMP_SUP OP_COMP_INF OP_COMP_SUP_EQ OP_EQUAL OP_DIFF
%token OP_ADD OP_SUB OP_MUL OP_DIV
%token ACCOLADE_OUV ACCOLADE_FER
%token PARENTHESE_OUV PARENTHESE_FER
%token PVG VIRGULE DEUX_POINTS

%%

programme:
    MC_DECLARATION DEUX_POINTS ACCOLADE_OUV liste_decl ACCOLADE_FER
    MC_CODE DEUX_POINTS ACCOLADE_OUV liste_inst ACCOLADE_FER
    MC_END PVG
    ;

liste_decl:
    liste_decl decl PVG
    | /* vide */
    ;

decl:
    type liste_idf
    ;

type:
    TYPE_int
    | TYPE_flot
    ;

liste_idf:
    IDF
    | liste_idf VIRGULE IDF
    ;

liste_inst:
    liste_inst instruction
    | /* vide */
    ;

instruction:
    affectation PVG
    | inst_print
    | inst_if
    ;

affectation:
    IDF OP_AFF expr
    ;

inst_print:
    MC_PRINT PARENTHESE_OUV CHAINE PARENTHESE_FER
    ;

inst_if:
    MC_IF PARENTHESE_OUV condition PARENTHESE_FER MC_DO ACCOLADE_OUV liste_inst ACCOLADE_FER
    ;

condition:
    expr op_comp expr
    ;

op_comp:
    OP_COMP_SUP
    | OP_COMP_INF
    | OP_COMP_SUP_EQ
    | OP_EQUAL
    | OP_DIFF
    ;

expr:
    expr OP_ADD terme
    | expr OP_SUB terme
    | terme
    ;

terme:
    terme OP_MUL facteur
    | terme OP_DIV facteur
    | facteur
    ;

facteur:
    IDF
    | CST_INT
    | CST_REEL
    | PARENTHESE_OUV expr PARENTHESE_FER
    ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "Erreur syntaxique a la ligne %d, colonne %d : %s\n", nb_ligne, nb_colonne, msg);
}

int main() {
    yyparse();
    return 0;
}