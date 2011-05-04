#include <locale.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>
#include <math.h>

#include "link-grammar.h"

int number_of_linkages(char *str) {
	Dictionary dict;
	Parse_Options opts;
	Sentence sentence;
	int num_linkages;
	
	setlocale(LC_ALL, "");
	opts = parse_options_create();
	dict = dictionary_create_lang("en");
	if(!dict) {
		printf("Fatal: no dictionary found\n");
		return 1;
	}
	sentence = sentence_create(str, dict);
	num_linkages = sentence_parse(sentence, opts);
	sentence_delete(sentence);
	dictionary_delete(dict);
	parse_options_delete(opts);
	return num_linkages;
}

/*
int main() {
	Dictionary dict;
	Parse_Options opts;
	Sentence sentence;
	Linkage linkage;
	char * diagram;
	int i, num_linkages;
	
	char * input_string[] = {
		"Grammar is useless because there's nothing to say -- Gertrude Stein.", 
		"Computers are useless; they can only give you answers -- Pablo Picasso."
	};
	
	opts = parse_options_create();
	dict = dictionary_create_lang("en");
	if(!dict) {
		printf("Fatal: no dictionary\n");
		return 1;
	}
	for(i=0;i<2;++i) {
		sentence = sentence_create(input_string[i], dict);
		num_linkages = sentence_parse(sentence, opts);
		printf("links=%d\n", num_linkages);
		if(num_linkages > 0) {
			linkage = linkage_create(0, sentence, opts);
			printf("%s\n", diagram = linkage_print_diagram(linkage));
			linkage_delete(linkage);
		}
		sentence_delete(sentence);
	}
	dictionary_delete(dict);
	parse_options_delete(opts);
	return 0;
}
*/