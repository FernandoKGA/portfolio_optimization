# Portfolio Optimization
Repository for a Portfolio Optimization proposed in the Problem Resolution 2 subject, following the 'Modern Portfolio Theory' of Markowitz.

## Instruções

Os arquivos necessários para rodar os scripts não estarão no formato pedido para os scripts serem rodados, eles devem ser extraídos através do script `zip_extractor.py`, devido ao tamanho dos arquivos individuais... Somente estarão presentes os arquivos compactados.


## Layout dos arquivos

5 colunas:
* Nome do campo/Descrição
* Conteúdo
* Tipo e Tamanho
* Posição Inicial
* Posição Final

Tipo e Tamanho

* N: Numérico;
* X: Alfanumérico;
* V: Indica que o número possui vírgula;
* (): Quantidade de caracteres antes da vírgula;
* (99): Quantidade de caracteres depois da vírgula;

### Estrutura do arquivo

NOME DO CAMPO / DESCRIÇÃO - CONTEÚDO - TIPO E TAMANHO - POS. INIC. - POS. FINAL

* Registro - 00 - Header

- TIPO DE REGISTRO - FIXO “00” - N(02) - 01 - 02 
- NOME DO ARQUIVO - FIXO “COTAHIST.AAAA” - X(13) - 03 - 15 
- CÓDIGO DA ORIGEM - FIXO “BOVESPA” - X(08) - 16 - 23 
- DATA DA GERAÇÃO DO ARQUIVO - FORMATO “AAAAMMDD” - N(08) - 24 - 31
- RESERVA - PREENCHER COM BRANCOS - X(214) - 32 - 245 

* Registro - 01 - Cotações dos papéis por dia

* Registro - 99 - Trailer
