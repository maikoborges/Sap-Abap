* DCLARAÇÃO DA ESTRUTURA
types: begin of ty_dados,
         nome type string,
         cod  type string,
       end of ty_dados.

data: w_area type ty_dados, " Work Área
      t_forn type table of ty_dados. " Tabela Interna

* Tabela interna c/ work área
data: begin of t_mat occurs 0,
        desc type string,
        cod  type string,
      end of t_mat.


* INCLUSÃO DE DADOS NAS TABELAS
*Sem HEADER LINE
w_area-nome = 'SAMSUNG'.
w_area-cod  = 'COD-001'.
append w_area to t_forn.
clear w_area.

w_area-nome = 'APPLLE'.
w_area-cod  = 'COD-002'.
append w_area to t_forn.
clear w_area.

* Com HEADER LINE
t_mat-desc = 'GALAXY 12'.
t_mat-cod  = 'COD-001'.
append t_mat.
clear t_mat.

t_mat-desc = 'IPHONE'.
t_mat-cod  = 'COD-002'.
append t_mat.
clear t_mat.

* LEITURA DE TABELAS PELO LOOP
write: 'LEITURA DA TABELA POR COMPLETO'.
skip.

* Com HEADER LINE
loop at t_mat.
  write: / 'Descrição do material:',t_mat-desc,
         / 'Código do material:',t_mat-cod.
  skip.
endloop.

* Sem HEADER LINE
loop at t_forn into w_area.
  write: / 'Nome do fornecedor:',w_area-nome,
         / 'Código do fornecedor:',w_area-cod.
  skip.
  clear w_area.
endloop.
uline.

* LEITURA DA TABELA PELO READ TABLE
write: / 'LENDO DADOS INDIVIDUAIS DA TABELA'.
skip.

* Com HEADER LINE
read table: t_mat index 1.
write: / 'Descrição do produto:',t_mat-desc,
       / 'Código do produto:',t_mat-cod.
clear t_mat.
skip.

* Sem HEADER LINE
read table: t_forn into data(linha) index 2.
write: / 'Nome do fornecedor:',linha-nome,
       / 'Código do fornecedor:',linha-cod.
clear w_area.
skip.
uline.

* MODIFICANDO DADOS DA TABELA INTERNA

* Com HEADER LINE
loop at t_mat.
  concatenate t_mat-desc 'Preto' into t_mat-desc separated by ' '. "Adicionando e separando dados"
  modify t_mat transporting desc.                                  "Modificando dados no campo descrição"
endloop.

* Sem HEADER LINE
loop at t_forn into w_area.
  concatenate w_area-nome 'CELULARES' into w_area-nome separated by ' '.
  modify t_forn from w_area transporting nome.
endloop.
