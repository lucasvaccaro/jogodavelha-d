module tabuleiro;

import std.math, std.conv;
import app;
import jogo : Jogo;
import jogador : Jogador;

class Tabuleiro
{
    private int tamanho;
    private string[] posicoes;
    
    this(int tamanho)
    {
        this.tamanho = tamanho;
        this.posicoes = new string[tamanho];
    }
    
    void montaTabuleiro()
    {
        int tam = to!int(sqrt(to!float(this.tamanho)));
        int posicao = 1;
        string desenha = "";
        
        for (int l = 1; l <= tam; l++) {
            for (int c = 1; c <= tam; c++) {
                if (this.posicoes[posicao-1] != "") {
                    desenha ~= "" ~ this.posicoes[posicao-1];
                } else {
                    if (posicao < 10) {
                        desenha ~= "";
                    }
                    desenha ~= to!string(posicao);
                }
                if (c < tam) {
                    desenha ~= "|";
                }
                posicao++;
            }
            if (l < tam) {
                desenha ~= "\n";
                for (int i = 0; i < tam; i++) {
                    desenha ~= "--";
                }
                desenha ~= "\n";
            }
        }
        
        app.println(desenha);
    }
    
    int getTamanho()
    {
        return this.tamanho;
    }
    
    void setPosicao(int i, string simbolo)
    {
        this.posicoes[i] = simbolo;
    }
    
    string getPosicao(int i)
    {
        return this.posicoes[i];
    }
}
