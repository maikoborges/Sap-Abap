
* Tabelas Transparentes
tables: spfli, zatraso_voo_estrutura, zatraso_voo.

* Estruturas Internas
data: custom_container        type ref to cl_gui_custom_container,           " Container da tela
      alv                     type ref to cl_gui_alv_grid,                   " Objeto do ALV
      fieldacat               type lvc_t_fcat,                               " Base do fieldcat do ALV
      t_zatraso_voo_estrutura type standard table of zatraso_voo_estrutura,  " Tabela interna
      w_zatraso_voo_estrutura LIKE line of t_zatraso_voo_estrutura,          " Work area baseada na tabela interna
      w_zatraso_voo           TYPE zatraso_voo.                            " Work area baseada na tabela transparente

* Subtela e Bloco de seleção
selection-screen begin of screen 01 as subscreen.                   " Subtela 
selection-screen begin of block bc01 with frame title text-001.     " Bloco de seleção 
select-options: s_carrid for spfli-carrid no intervals,
                s_connid for spfli-connid no intervals,
                s_cityfr for spfli-cityfrom no intervals,
                s_cityto for spfli-cityto no intervals.
selection-screen end of block bc01.
selection-screen end of screen 01.