<%@page import="util.Conexao"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Upload" %>


<%
    Statement st = null;
    ResultSet rs = null;

    String nome = "";
    String qtddisponivel = "";
    String preco = "";
    String numero = "";
    //String categoria = "";
    String imagem = null;

    String id = "";
    String antigo = "";

    //definir qual a pasta a ser salva
    Upload up = new Upload();
    up.setFolderUpload("img");

    //out.print(up.getForm().get("nome ").toString());
    if (up.formProcess(getServletContext(), request)) {

        try {
            nome = up.getForm().get("nome").toString();
            qtddisponivel = up.getForm().get("quantidade").toString();
            preco = up.getForm().get("preco").toString();
            preco = preco.replace(",", ".");
            numero = up.getForm().get("numero").toString();

            //categoria = up.getForm().get("categoria").toString();
            id = up.getForm().get("txtid").toString();
            antigo = up.getForm().get("antigo").toString();
            imagem = up.getFiles().get(0).toString();

        } catch (Exception e) {
            imagem = "sem-foto.jpg";
        }

        // INSERIR DADOS NO BANCO
        try {

            //VERIFICAR SE O CAMPO ESTÁ VAZIO
            if (nome.equals("")) {
                out.print("Preencha o campo Quantidade!");
                return;
            }

            if (qtddisponivel.equals("")) {
                out.print("Preencha o campo Quantidade!");
                return;
            }

            if (preco.equals("")) {
                out.print("Preencha o campo Preço!");
                return;
            }

            if (numero.equals("")) {
                out.print("Preencha o campo Numero!");
                return;
            }

            st = new Conexao().conectar().createStatement();

            // VERIFICAR SE JÁ EXISTE REGISTRO COM MESMO NOME
            if (!numero.equals(antigo)) {
                rs = st.executeQuery("SELECT * FROM produtos where numero = '" + numero + "'");
                while (rs.next()) {
                    rs.getRow();
                    if (rs.getRow() > 0) {
                        out.print("Registro Já Cadastrado!");
                        return;
                    }
                }
            }

            if (id.equals("")) {
                st.executeUpdate("INSERT into produtos (nome,qtddisponivel, preco, numero, imagem) values ('" + nome + "','" + qtddisponivel + "', '" + preco + "', '" + numero + "','" + imagem + "')");
            } else {
                if (imagem.equals("sem-foto.jpg")) {
                    st.executeUpdate("UPDATE produtos SET nome ='" + nome + "',qtddisponivel ='" + qtddisponivel + "',preco ='" + preco + "',numero ='" + numero + "' where id = '" + id + "' ");
                } else {
                    st.executeUpdate("UPDATE produtos SET nome ='" + nome + "',qtddisponivel ='" + qtddisponivel + "',preco ='" + preco + "', numero ='" + numero + "' ,imagem ='" + imagem + "'where id = '" + id + "' ");
                }

            }

            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    }
%>