# Portfolio Optimization
Repository for a Portfolio Optimization proposed in the Problem Resolution 2 subject, following the 'Modern Portfolio Theory' of Markowitz.

## Objetivos 
O objetivo do trabalho é a criação de uma aplicação que efetue os cálculos de otimização carteiras de ações. A otimização consiste em aplicação de restrições a um portfólio de ações. Dessa forma a aplicação deve apresentar as opções ao usuário e apresentar no final um ranking de risco e retorno dos ações que compõem esse portfólio de acordo com as entradas do usuário, ou seja, seu perfil.

## Instruções

Os arquivos necessários para a execução dos scripts deverão ser extraídos e inicializados. Para tal, execute o script `prep_env.jl`. Devido ao tamanho dos arquivos individuais, estes estarão presentes apenas no formato compactado.


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

- TIPREG - TIPO DE REGISTRO - FIXO "01" - N(02) - 01 - 02
- DATA DO PREGÃO - FORMATO "AAAAMMDD" - N(08) - 03 - 10
- CODBDI - CÓDIGO BDI - UTILIZADO PARA CLASSIFICAR OS PAPÉIS NA EMISSÃO DO BOLETIM DIÁRIO DE INFORMAÇÕES(TABELA ANEXA) - X(02) - 11 - 12
- CODNEG - CÓDIGO DE NEGOCIAÇÃO DO PAPEL - - X(12) - 13 - 24
- TPMERC - TIPO DE MERCADO - CÓD. DO MERCADO EM QUE O PAPEL ESTÁ CADASTRADO(TABELA ANEXA) - N(03) - 25 - 27
- NOMRES - NOME RESUMIDO DA EMPRESA EMISSORA DO PAPEL - - X(12) - 28 - 39
- ESPECI - ESPECIFICAÇÃO DO PAPEL - VER TABELA ANEXA - X(10) - 40 - 49
- PRAZOT- PRAZO EM DIAS DO MERCADO A TERMO - - X(03) - 50 - 52
- MODREF - MOEDA DE REFERÊNCIA - MOEDA USADA NA DATA DO PREGÃO - X(04) - 53 - 56
- PREABE - PREÇO DE ABERTURA DO PAPEL-MERCADO NO PREGÃO - - (11)V99 - 57 - 69
- PREMAX - PREÇO MÁXIMO DO PAPEL-MERCADO NO PREGÃO - - (11)V99 - 70 - 82
- PREMIN - PREÇO MÍNIMO DO PAPEL-MERCADO NO PREGÃO - - (11)V99 - 83 - 95
- PREMED - PREÇO MÉDIO DO PAPEL- MERCADO NO PREGÃO - - (11)V99 - 96 - 108
- PREULT - PREÇO DO ÚLTIMO NEGÓCIO DO PAPEL-MERCADO NO PREGÃO - - (11)V99 - 109 - 121
- PREOFC - PREÇO DA MELHOR OFERTA DE COMPRA DO PAPELMERCADO - - (11)V99 - 122 - 134
- PREOFV - PREÇO DA MELHOR OFERTA DE VENDA DO PAPELMERCADO - - (11)V99 - 135 - 147
- TOTNEG - NEG. - NÚMERO DE NEGÓCIOS EFETUADOS COM O PAPEL- MERCADO NO PREGÃO - - N(05) - 148 - 152
- QUATOT - QUANTIDADE TOTAL DE TÍTULOS NEGOCIADOS NESTE PAPEL- MERCADO - - N(18) - 153 - 170
- VOLTOT - VOLUME TOTAL DE TÍTULOS NEGOCIADOS NESTE PAPEL- MERCADO - - (16)V99 - 171 - 188
- PREEXE - PREÇO DE EXERCÍCIO PARA O MERCADO DE OPÇÕES OU VALOR DO CONTRATO PARA O MERCADO DE TERMO SECUNDÁRIO - - (11)V99 - 189 - 201
- INDOPC - INDICADOR DE CORREÇÃO DE PREÇOS DE EXERCÍCIOS OU VALORES DE CONTRATO PARA OS MERCADOS DE OPÇÕES OU TERMO SECUNDÁRIO - VER TABELA ANEXA - N(01) - 202 - 202
- DATVEN - DATA DO VENCIMENTO PARA OS MERCADOS DE OPÇÕES OU TERMO SECUNDÁRIO - FORMATO "AAAAMMDD" - N(08) - 203 - 210
- FATCOT - FATOR DE COTAÇÃO DO PAPEL - ‘1’ = COTAÇÃO UNITÁRIA 
‘1000’ = COTAÇÃO POR LOTE DE MIL AÇÕES - N(07) - 211 - 217
- PTOEXE - PREÇO DE EXERCÍCIO EM PONTOS PARA OPÇÕES REFERENCIADAS EM DÓLAR OU VALOR DE CONTRATO EM PONTOS PARA TERMO SECUNDÁRIO - PARA OS REFERENCIADOS EM DÓLAR, CADA PONTO EQUIVALE AO VALOR, NA MOEDA CORRENTE, DE UM CENTÉSIMO DA TAXA MÉDIA DO DÓLAR COMERCIAL INTERBANCÁRIO DE FECHAMENTO DO DIA ANTERIOR, OU SEJA, 1 PONTO = 1/100 US$ - (07)V06 - 218 - 230
- CODISI - CÓDIGO DO PAPEL NO SISTEMA ISIN OU CÓDIGO INTERNO DO PAPEL - CÓDIGO DO PAPEL NO SISTEMA ISIN A PARTIR DE 15-05-1995 - X(12) - 231 - 242
- DISMES - NÚMERO DE DISTRIBUIÇÃO DO PAPEL - NÚMERO DE SEQÜÊNCIA DO PAPEL CORRESPONDENTE AO ESTADO DE DIREITO VIGENTE - 9(03) 243 - 245

* Registro - 99 - Trailer

- TIPO DE REGISTRO - FIXO "99" - N(02) - 01 - 02
- NOME DO ARQUIVO - FIXO "COTAHIST.AAAA" - X(13) - 03 - 15
- CÓDIGO DE ORIGEM - FIXO "BOVESPA" - X(08) - 16 - 23
- DATA DA GERAÇÃO DO ARQUIVO - FORMATO "AAAAMMDD" - N(08) - 24 - 31
- TOTAL DE REGISTROS - INCLUIR TAMBÉM OS REGISTROS HEADER E TRAILER - N(11) - 32 - 42
- RESERVA - PREENCHER COM BRANCOS - X(203) - 43 - 245

### TABELAS ANEXAS

* TABELA DE CODBDI - RELAÇÃO DOS VALORES PARA CÓDIGOS DE BDI

02 LOTE PADRAO 
05 SANCIONADAS PELOS REGULAMENTOS BMFBOVESPA 
06 CONCORDATARIAS 
07 RECUPERACAO EXTRAJUDICIAL 
08 RECUPERAÇÃO JUDICIAL 
09 RAET - REGIME DE ADMINISTRACAO ESPECIAL TEMPORARIA 
10 DIREITOS E RECIBOS 
11 INTERVENCAO 
12 FUNDOS IMOBILIARIOS 
14 CERT.INVEST/TIT.DIV.PUBLICA 
18 OBRIGACÕES 
22 BÔNUS (PRIVADOS) 
26 APOLICES/BÔNUS/TITULOS PUBLICOS 
32 EXERCICIO DE OPCOES DE COMPRA DE INDICES 
33 EXERCICIO DE OPCOES DE VENDA DE INDICES 
38 EXERCICIO DE OPCOES DE COMPRA 
42 EXERCICIO DE OPCOES DE VENDA 
46 LEILAO DE NAO COTADOS 
48 LEILAO DE PRIVATIZACAO 
49 LEILAO DO FUNDO RECUPERACAO ECONOMICA ESPIRITO SANTO 
50 LEILAO 
51 LEILAO FINOR 
52 LEILAO FINAM 
53 LEILAO FISET 
54 LEILAO DE ACÕES EM MORA 
56 VENDAS POR ALVARA JUDICIAL 
58 OUTROS 
60 PERMUTA POR ACÕES 
61 META 
62 MERCADO A TERMO 
66 DEBENTURES COM DATA DE VENCIMENTO ATE 3 ANOS
68 DEBENTURES COM DATA DE VENCIMENTO MAIOR QUE 3 ANOS 
70 FUTURO COM RETENCAO DE GANHOS 
71 MERCADO DE FUTURO 
74 OPCOES DE COMPRA DE INDICES 
75 OPCOES DE VENDA DE INDICES 
78 OPCOES DE COMPRA 
82 OPCOES DE VENDA 
83 BOVESPAFIX 
84 SOMA FIX 
90 TERMO VISTA REGISTRADO 
96 MERCADO FRACIONARIO 
99 TOTAL GERAL 

* TABELA DE ESPECI - RELAÇÃO DE VALORES PARA ESPECIFICAÇÃO

BDR  BDR  
BNS  BÔNUS DE SUBSCRIÇÃO EM ACÕES MISCELÂNEA  
BNS B/A  BÔNUS DE SUBSCRIÇÃO EM ACÕES PREFERÊNCIA 
BNS ORD  BÔNUS DE SUBSCRIÇÃO EM ACÕES ORDINÁRIAS  
BNS P/A  BÔNUS DE SUBSCRIÇÃO EM ACÕES PREFERÊNCIA 
BNS P/B  BÔNUS DE SUBSCRIÇÃO EM ACÕES PREFERÊNCIA 
BNS P/C  BÔNUS DE SUBSCRIÇÃO EM ACÕES PREFERÊNCIA 
BNS P/D  BÔNUS DE SUBSCRIÇÃO EM ACÕES PREFERÊNCIA 
BNS P/E  BÔNUS DE SUBSCRIÇÃO EM ACÕES PREFERÊNCIA 
BNS P/F  BÔNUS DE SUBSCRIÇÃO EM ACÕES PREFERÊNCIA 
BNS P/G  BÔNUS DE SUBSCRIÇÃO EM ACÕES PREFERÊNCIA 
BNS P/H  BÔNUS DE SUBSCRIÇÃO EM ACÕES PREFERÊNCIA 
BNS PRE  BÔNUS DE SUBSCRIÇÃO EM ACÕES PREFERÊNCIA 
CDA  CERTIFICADO DE DEPÓSITO DE ACÕES ORDINÁRIAS 
CI  FUNDO DE INVESTIMENTO  
CPA  CERTIF. DE POTENCIAL ADIC. DE CONSTRUÇÃO 
DIR  DIREITOS DE SUBSCRIÇÃO MISCELÂNEA (BÔNUS) 
DIR ORD  DIREITOS DE SUBSCRIÇÃO EM ACÕES ORDINÁRIAS  
DIR P/A  DIREITOS DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
DIR P/B  DIREITOS DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
DIR P/C  DIREITOS DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
DIR P/D  DIREITOS DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
DIR P/E  DIREITOS DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
DIR P/F  DIREITOS DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
DIR P/G  DIREITOS DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
DIR P/H  DIREITOS DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
DIR PR  DIREITOS DE SUBSCRIÇÃO EM ACÕES RESGATÁVEIS 
DIR PRA  DIREITOS DE SUBSCRIÇÃO EM ACÕES RESGATÁVEIS 
DIR PRB  DIREITOS DE SUBSCRIÇÃO EM ACÕES RESGATÁVEIS 
DIR PRC  DIREITOS DE SUBSCRIÇÃO EM ACÕES RESGATÁVEIS 
DIR PRE  DIREITOS DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
LFT  LETRA FINANCEIRA DO TESOURO  
M1 REC  RECIBO DE SUBSCRIÇÃO DE MISCELÂNEAS  
ON  ACÕES ORDINÁRIAS NOMINATIVAS  
ON P  ACÕES ORDINÁRIAS NOMINATIVAS COM DIREITO 
ON REC  RECIBO DE SUBSCRIÇÃO EM ACÕES ORDINÁRIAS  
OR  ACÕES ORDINÁRIAS NOMINATIVAS RESGATÁVEIS 
OR P  ACÕES ORDINÁRIAS NOMINATIVAS RESGATÁVEIS 
PCD  POSIÇÃO CONSOLIDADA DA DIVIDA  
PN  ACÕES PREFERÊNCIAIS NOMINATIVAS  
PN P  ACÕES PREFERÊNCIAIS NOMINATIVAS COM DIREITO 
PN REC  RECIBO DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
PNA  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE A
PNA P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE A 
PNA REC  RECIBO DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS
PNB  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE B 
PNB P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE B 
PNB REC  RECIBO DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
PNC  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE C 
PNC P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE C 
PNC REC  RECIBO DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
PND  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE D 
PND P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE D 
PND REC  RECIBO DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
PNE  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE E 
PNE P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE E 
PNE REC  RECIBO DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
PNF  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE F 
PNF P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE F 
PNF REC  RECIBO DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
PNG  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE G 
PNG P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE G 
PNG REC  RECIBO DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
PNH  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE H 
PNH P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE H 
PNH REC  RECIBO DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
PNR  ACÕES PREFERÊNCIAIS NOMINATIVAS RESGATÁVEIS 
PNV  ACÕES PREFERÊNCIAS NOMINATIVAS COM DIREITO 
PNV P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE V 
PNV REC  RECIBO DE SUBSCRIÇÃO EM ACÕES PREFERENCIAIS 
PR P  ACÕES PREFERÊNCIAIS NOMINATIVAS RESGATÁVEIS 
PRA  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE A 
PRA P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE A
PRA REC  RECIBO DE SUBSCRIÇÃO EM ACÕES RESGATÁVEIS 
PRB  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE B 
PRB P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE B 
PRB REC   DIREITOS DE SUBSCRIÇÃO EM ACÕES RESGATÁVEIS 
PRB REC  RECIBO DE SUBSCRIÇÃO EM ACÕES RESGATÁVEIS 
PRC  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE C 
PRC P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE C 
PRC REC  RECIBO DE SUBSCRIÇÃO EM ACÕES RESGATÁVEIS 
PRD  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE D 
PRD P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE D 
PRE  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE E 
PRE P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE E 
PRF   ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE F 
PRF P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE F 
PRG  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE G 
PRG P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE G 
PRH  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE H 
PRH P  ACÕES PREFERÊNCIAIS NOMINATIVAS CLASSE H 
PRV  ACÕES PREFERÊNCIAIS NOMINATIVAS COM DIREITO 
PRV P  ACÕES PREFERÊNCIAIS NOMINATIVAS RESG. C/ DIREITO 
R  CESTA DE ACÕES NOMINATIVAS  
REC  RECIBO DE SUBSCRIÇÃO MISCELÂNEA  
REC PR  RECIBO DE SUBSCRIÇÃO EM PREF RESGATÁVEIS  
RON  CESTA DE ACÕES ORDINÁRIAS NOMINATIVAS  
TPR  TIT. PERPETUOS REMUN. VARIAV. ROYALTIES  
UNT  CERTIFICADO DE DEPÓSITO DE ACÕES - MISCELÂNEAS 
UNT  UNITS  
UP  PRECATÓRIO  
WRT  WARRANTS DE DEBÊNTURES 

* TABELA DE INDOPC - RELAÇÃO DOS VALORES PARA CORREÇÃO DE CONTRATOS

1 US$ CORREÇÃO PELA TAXA DO DÓLAR 
2 TJLP CORREÇÃO PELA TJLP 
8 IGPM (PROTEGI DA) CORREÇÃO PELO IGP-M - OPÇÕES PROTEGIDAS 
9 URV CORREÇÃO PELA URV 

* TABELA DE TPMERC - RELAÇÃO DOS VALORES PARA TIPO DE MERCADO

010 VISTA 
012 EXERCÍCIO DE OPÇÕES DE COMPRA 
013 EXERCÍCIO DE OPÇÕES DE VENDA 
017 LEILÃO 
020 FRACIONÁRIO 
030 TERMO 
050 FUTURO COM RETENÇÃO DE GANHO 
060 FUTURO COM MOVIMENTAÇÃO CONTÍNUA 
070 OPÇÕES DE COMPRA 
080 OPÇÕES DE VENDA 
