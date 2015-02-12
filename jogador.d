module jogador;

class Jogador
{
    private string nome;
    private string simbolo;
    
    this(string nome, string simbolo)
    {
        this.nome = nome;
        this.simbolo = simbolo;
    }
    
    void setNome(string nome)
    {
        this.nome = nome;
    }
    
    string getNome()
    {
        return this.nome;
    }
    
    void setSimbolo(string simbolo)
    {
        this.simbolo = simbolo;
    }
    
    string getSimbolo()
    {
        return this.simbolo;
    }
}