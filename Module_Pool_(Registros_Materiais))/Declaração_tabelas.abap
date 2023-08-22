
* Tabela transparente
tables: zt006, zt007.

* Tipos
types: begin of ty_zt007.
         include structure zt007.   " Criando uma types com base nessa tabela
         types: mark.               " Adicionando este campo na estrutura do type
types: end of ty_zt007.

* Variáveis
data: v_deno_bukrs type ze002,
      v_deno_forne type ze002,
      v_deno_compr type ze002.

* Work Area
data: w_zt006 type zt006.

data: t_zt007 type standard table of ty_zt007 with header line.

* Controls  ( Definição dos controles da tela, e associação a tela 0100)
controls: tc_0100 type tableview using screen 0100.

* Constante da tabscript em estrutura
constants: begin of c_tb_0100,
             tab1 like sy-ucomm value 'TB_0100_FC1',
             tab2 like sy-ucomm value 'TB_0100_FC2',
           end of c_tb_0100.

* Tabscript
controls tb_0100 type tabstrip.

* Work area da tabscrip
data: begin of w_tb_0100,
        subscreen   like sy-dynnr,
        progr       like sy-repid value 'SAPMZ001',
        pressed_tab like sy-ucomm value C_TB_0100-TAB1,
      end of w_tb_0100.