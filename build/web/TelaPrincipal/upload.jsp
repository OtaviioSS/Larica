<%@page import="util.Conexao"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Upload" %>


<%
    Statement st = null;
    ResultSet rs = null;

    String nomeProduto = "";
    String nome = "";
    String endereco = "";
    String qtd = "";
    String numero = "";
    String frmpag = "";
    String vlrTotal = "";

    //String categoria = "";
    String id = "";
    String antigo = "";

    //definir qual a pasta a ser salva
    Upload up = new Upload();

    //out.print(up.getForm().get("nome ").toString());
    if (up.formProcess(getServletContext(), request)) {

        try {
            endereco = up.getForm().get("endereco").toString();
            nome = up.getForm().get("nome").toString();
            qtd = up.getForm().get("qtd").toString();
            frmpag = up.getForm().get("forma").toString();
            nomeProduto = up.getForm().get("nomeProduto").toString();
            vlrTotal = up.getForm().get("vlrTotal").toString();

            //categoria = up.getForm().get("categoria").toString();
            id = up.getForm().get("txtid").toString();
            antigo = up.getForm().get("antigo").toString();

        } catch (Exception e) {

        }
        try {

            //VERIFICAR SE O CAMPO ESTÁ VAZIO
            if (endereco.equals("")) {
                out.print("Preencha o campo Endereço!");
                return;
            }
            if (nome.equals("")) {
                out.print("Preencha o campo Nome!");
                return;
            }

            if (qtd.equals("")) {
                out.print("Preencha o campo Quantidade!");
                return;
            }

            if (frmpag.equals("")) {
                out.print("Preencha o campo Forma de Pagamento!");
                return;
            }

            st = new Conexao().conectar().createStatement();

            // VERIFICAR SE JÁ EXISTE REGISTRO COM MESMO NOME
            if (!numero.equals(antigo)) {
                rs = st.executeQuery("SELECT * FROM carrinho where nome = '" + nomeProduto + "'");
                while (rs.next()) {
                    rs.getRow();
                    if (rs.getRow() > 0) {
                        out.print("Registro Já Cadastrado!");
                        return;
                    }
                }
            }

            if (id.equals("")) {
                st.executeUpdate("INSERT into carrinho (nomecliente,nomeproduto,endereco, frmpag,vlrtotal,qtd) values ('" + nome + "','" + nomeProduto + "','" + endereco + "', '" + frmpag + "','" + vlrTotal + "','" + qtd + "')");
            }
            /*else {
                if (imagem.equals("sem-foto.jpg")) {
                    st.executeUpdate("UPDATE produtos SET nome ='" + nome + "',qtddisponivel ='" + qtddisponivel + "',preco ='" + preco + "',numero ='" + numero + "' where id = '" + id + "' ");
                } else {
                    st.executeUpdate("UPDATE produtos SET nome ='" + nome + "',qtddisponivel ='" + qtddisponivel + "',preco ='" + preco + "', numero ='" + numero + "' ,imagem ='" + imagem + "'where id = '" + id + "' ");
                }

            }*/
            out.print("Adicionado com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    }
%>