<%@page import="util.Conexao"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Upload" %>


<%

    Statement st = null;
    ResultSet rs = null;

    String nome = "";
    String endereco = "";
    String cpf = "";
    String email = "";
    String cep = "";
    String cidade = "";
    String uf = "";
    String telefone = "";
    String imagem = null;

    String id = "";
    String antigo = "";

    //definir qual a pasta a ser salva
    Upload up = new Upload();
    up.setFolderUpload("img");

    //out.print(up.getForm().get("nome ").toString());
    if (up.formProcess(getServletContext(), request)) {

        try {
            nome = up.getForm().get("txtnome").toString();
            endereco = up.getForm().get("txtendereco").toString();
            cpf = up.getForm().get("txtcpf").toString();
            email = up.getForm().get("txtemail").toString();
            cep = up.getForm().get("txtcep").toString();
            cidade = up.getForm().get("txtcidade").toString();
            uf = up.getForm().get("txtuf").toString();
            telefone = up.getForm().get("txttelefone").toString();

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
                out.print("Preencha o campo Nome!");
                return;
            }

            if (endereco.equals("")) {
                out.print("Preencha o campo endereco!");
                return;
            }
            if (cpf.equals("")) {
                out.print("Preencha o campo cpf!");
                return;
            }
            if (email.equals("")) {
                out.print("Preencha o campo email!");
                return;
            }
            if (cep.equals("")) {
                out.print("Preencha o campo cep!");
                return;
            }
            if (cidade.equals("")) {
                out.print("Preencha o campo cidade!");
                return;
            }
            if (uf.equals("")) {
                out.print("Preencha o campo uf!");
                return;
            }
            if (telefone.equals("")) {
                out.print("Preencha o campo telefone!");
                return;
            }

            st = new Conexao().conectar().createStatement();
            // VERIFICAR SE JÁ EXISTE REGISTRO COM MESMO NOME

            if (!nome.equals(antigo)) {
                rs = st.executeQuery("SELECT * FROM clientes where nome = '" + nome + "'");
                while (rs.next()) {
                    rs.getRow();
                    if (rs.getRow() > 0) {
                        out.print("Registro Já Cadastrado!");
                        return;
                    }
                }
            }

            if (id.equals("")) {
                st.executeUpdate("INSERT into clientes (nome, endereco, cpf, email, cep, cidade, uf, telefone, imagem	) values ('" + nome + "', '" + endereco + "', '" + cpf + "', '" + email + "', '" + cep + "', '" + cidade + "', '" + uf + "', '" + telefone + "','" + imagem + "')");
            } else {
                if (imagem.equals("sem-foto.jpg")) {
                    st.executeUpdate("UPDATE clientes SET nome ='" + nome + "', endereco = '" + endereco + "', cpf = '" + cpf + "', email = '" + email + "', cep = '" + cep + "', cidade = '" + cidade + "', uf = '" + uf + "', telefone = '" + telefone + "' where id = '" + id + "' ");
                } else {
                    st.executeUpdate("UPDATE clientes SET nome ='" + nome + "', endereco = '" + endereco + "', cpf = '" + cpf + "', email = '" + email + "', cep = '" + cep + "', cidade = '" + cidade + "', uf = '" + uf + "', telefone = '" + telefone + "', imagem = '" + imagem + "' where id = '" + id + "' ");
                }

            }

            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    }
%>