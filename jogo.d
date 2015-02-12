module jogo;

import std.stdio, std.math, std.conv, std.string;

import app;
import tabuleiro : Tabuleiro;
import jogador : Jogador;

class Jogo
{
    private int rodada;
    private Jogador[] jogadores;
    private Tabuleiro tab;
    
    this(Tabuleiro tab, Jogador j1, Jogador j2)
    {
        this.rodada = 1;
        this.tab = tab;
        this.jogadores = new Jogador[2];
        this.jogadores[0] = j1;
        this.jogadores[1] = j2;
    }
    
    void joga()
    {
    	string vencedor = null;
	    do {
	    	this.tab.montaTabuleiro();
	    	this.jogaRodada();
	    	vencedor = this.verificaVencedor();
	    } while (vencedor == null);
	    this.tab.montaTabuleiro();
	    app.print_ln("Vencedor: " ~ vencedor);
    }
    
    /**
     * Define o jogador que ira jogar. Se a rodada for impar, jogador 1. Se a rodada for par, jogador 2.
     * Pede e verifica a posicao da jogada.
     * Atualiza o tabuleiro.
     */
    void jogaRodada()
    {
        Jogador j;
        if (this.rodada % 2 != 0) {
            j = this.jogadores[0];
        } else {
            j = this.jogadores[1];
        }
        app.print_ln("Rodada " ~ to!string(this.rodada));
        app.print_ln("Agora eh a vez de " ~ j.getNome() ~ " (" ~ j.getSimbolo() ~ ")");
        
        int posicao;
        bool verifica_posicao = false;
        
        do {
        	app.print_ln("Informe a posicao da jogada: ");
        	try {
        		posicao = to!int(chomp(readln()));
        		if (posicao < 1 || posicao > this.tab.getTamanho()) {
	                verifica_posicao = false;
	                throw new Exception("Posicao invalida.");
	            } else {
	                posicao--; // array comeca em 0
	                verifica_posicao = this.verificaPosicao(posicao);
	                if (verifica_posicao == false) {
	                    app.print_ln("Esta posicao ja foi utilizada no jogo.");
	                }
	            }
        	} catch (Exception e) {
        		app.print_ln("Posicao invalida.");
        	}
        } while (verifica_posicao == false);
        
        this.tab.setPosicao(posicao, j.getSimbolo());
        this.rodada++;
    }
    
    /**
     * Verifica se a posicao da jogada esta vazia ou ja foi usada no jogo
     * @param posicao
     * @return true se pode jogar, false se nao
     */
    bool verificaPosicao(int posicao)
    {
        return this.tab.getPosicao(posicao) == "";
    }
    
    /**
     * Verifica se ha um vencedor no jogo.
     * @return jogador vencedor ou null
     */
    string verificaVencedor()
    {
        int tamanho = this.tab.getTamanho();
        int tam = to!int(sqrt(to!float(tamanho)));
        
        // jogadores
        for (int i = 0; i <= 1; i++) {
            bool igual = false;
            Jogador j = this.jogadores[i];
            string simbolo = j.getSimbolo();
            
            // linhas
            for (int l = 0; l < tamanho; l += tam) {
                for (int p = l; p < l + tam; p++) {
                    if (this.tab.getPosicao(p) == simbolo) {
                        igual = true;
                    } else {
                        igual = false;
                        break;
                    }
                }
                
                if (igual) {
                    return j.getNome() ~ " (" ~ j.getSimbolo() ~ ")";
                }
            }
            
            // colunas
            for (int c = 0; c < tam; c++) {
                for (int p = c; p < tamanho; p += tam) {
                    if (this.tab.getPosicao(p) == simbolo) {
                        igual = true;
                    } else {
                        igual = false;
                        break;
                    }
                }
                
                if (igual) {
                    return j.getNome() ~ " (" ~ j.getSimbolo() ~ ")";
                }
            }
            
            // diagonais
            
            for (int d = 0; d < tamanho; d += tam + 1) {
                if (this.tab.getPosicao(d) == simbolo) {
                    igual = true;
                } else {
                    igual = false;
                    break;
                }
            }
            
            if (igual) {
                return j.getNome() ~ " (" ~ j.getSimbolo() ~ ")";
            }
            
            for (int d = tam - 1; d <= tamanho - tam; d += tam - 1) {
                if (this.tab.getPosicao(d) == simbolo) {
                    igual = true;
                } else {
                    igual = false;
                    break;
                }
            }
            
            if (igual) {
                return j.getNome() ~ " (" ~ j.getSimbolo() ~ ")";
            }
        }
        
        // verifica se acabou o jogo
        if (this.rodada > this.tab.getTamanho()) {
            return "Ninguem ganhou";
        }
        
        return null;
    }
}
