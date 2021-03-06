%{
        #include "funciones.h"
	FILE *fichero;
%}

%union{
   char *sval;
   int ival;
};

%token <sval> NOTEMOD NOTE SILENT
%token <ival> NUM

%token end

%start Linea


%%

Linea:	
	/* EMPTY */
	|Nota Linea	{}
	;

Nota:	NOTE Mods Dura	{
			  escribir(fichero, $1);
			}
	;

Mods:	
	/* EMPTY */	
	|Mods NOTEMOD	{
			    escribir(fichero, $2);
			}
	;

Dura:
	/* EMPTY */	
	|Dura NUM	{
			    escribirTiempo(fichero, $2);
			}

%%

int main( int argc, char **argv){
	
	fichero = fopen("Partitura.l", "w");
	
	escribir_encabezado(fichero);
	yyparse();
	escribir_piePagina(fichero);

	fclose(fichero);
	
	
}

int yyerror(char *s){
	printf("Error: %s \n", s);
}
