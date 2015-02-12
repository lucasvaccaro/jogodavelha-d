module app;

import std.stdio, std.math, std.conv, std.string;

import jogo : Jogo;
import tabuleiro : Tabuleiro;
import jogador : Jogador;

void main()
{
    print_ln("Bem-vindo ao jogo da velha!");
    print_ln("Pressione Enter para comecar.");
    
    print("Jogador 1 (X) > Informe seu nome: ");
    Jogador j1 = new Jogador(chomp(readln()), "X");
    
    print("Jogador 2 (O) > Informe seu nome: ");
    Jogador j2 = new Jogador(chomp(readln()), "O");
    
    int tamanho;
    do {
    	print("Informe o tamanho do tabuleiro (Digite 9 [3x3] ou 16 [4x4] ou 25 [5x5]): ");
    	try {
	        tamanho = to!int(chomp(readln()));
	        if (tamanho != 9 && tamanho != 16 && tamanho != 25) {
	        	throw new Exception("Tamanho inválido.");
	        }
        } catch (Exception e) {
        	print_ln("Tamanho invalido.");
        }
    } while (tamanho != 9 && tamanho != 16 && tamanho != 25);
    Tabuleiro tab = new Tabuleiro(tamanho);
    Jogo jogo = new Jogo(tab, j1, j2);
	jogo.joga();

}

void print(string txt)
{
	write(txt);
}

void print_ln(string txt)
{
	writeln(txt);
}

void println(string txt)
{
	writeln(txt);
}
