<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<% String pag = "clientes"; %>
<% String buscar = request.getParameter("txtbuscar"); %>

<%

    Statement st = null;
    ResultSet rs = null;
%>
<div class="container">
    <% out.print("<table class='table table-sm table-striped' style='font-size: 11px'>"
                + "<thead>"
                + "<tr>"
                + "<th scope='col'>Nome</th>"
                + "<th scope='col'>Endereco</th>"
                + "<th scope='col'>Cpf</th>"
                + "<th scope='col'>Email</th>"
                + "<th scope='col'>Cep</th>"
                + "<th scope='col'>Cidade</th>"
                + "<th scope='col'>Uf</th>"
                + "<th scope='col'>Telefone</th>"
                + "<th scope='col'>Imagem</th>"
                + "<th scope='col'>Ações</th>"
                + "</tr>"
                + "</thead>"
                + "<tbody>");

        try {

            st = new Conexao().conectar().createStatement();
            if (buscar != null) {
                buscar = '%' + buscar + '%';
                rs = st.executeQuery("SELECT * FROM clientes where nome LIKE '" + buscar + "' order by nome asc");
            } else {
                rs = st.executeQuery("SELECT * FROM clientes order by nome asc");
            }

            while (rs.next()) {

                out.print("<tr>");

                out.print("<td>" + rs.getString(2) + "</td>");
                out.print("<td>" + rs.getString(3) + "</td>");
                out.print("<td>" + rs.getString(4) + "</td>");
                out.print("<td>" + rs.getString(5) + "</td>");
                out.print("<td>" + rs.getString(6) + "</td>");
                out.print("<td>" + rs.getString(7) + "</td>");
                out.print("<td>" + rs.getString(8) + "</td>");
                out.print("<td>" + rs.getString(9) + "</td>");
                out.print("<td> <img src='img/" + rs.getString(10) + "'width='40'></td>");

                out.print("<td>");
                out.print("<a href='" + pag + ".jsp?funcao=editar&id=" + rs.getString(1) + "' class='text-info mr-1' title='Editar Dados'><i class='far fa-edit'></i></a>");
                out.print("<a href='" + pag + ".jsp?funcao=excluir&id=" + rs.getString(1) + "' class='text-danger' title='Excluir Dados'><i class='far fa-trash-alt'></i></a>");
                out.print("</td>");

                out.print("</tr>");

            }
        } catch (Exception e) {
            out.print(e);
        }

        out.print("</tbody>"
                + "</table>");

    %>
</div>