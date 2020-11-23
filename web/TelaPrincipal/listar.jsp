<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<% String pag = "produtos"; %>
<% String buscar = request.getParameter("txtbuscar"); %>
<% String nomeCat = ""; %>
<%

    Statement st, st2 = null;
    ResultSet rs, rs2 = null;
%>

<% out.print(" <table class='table table-sm table-striped' style='font-size: 11px'>"
            + "<thead>"
            + "<tr>"
            + "<th scope='col'>Nome</th>"
            + "<th scope='col'>Quantidade</th>"
            + "<th scope='col'>Preço</th>"
            + "<th scope='col'>Numero</th>"
            + "<th scope='col'>Imagem</th>"
            + "<th scope='col'>Ações</th>"
            + "</tr>"
            + "</thead>"
            + "<tbody>");

    try {

        st = new Conexao().conectar().createStatement();
        st2 = new Conexao().conectar().createStatement();

        if (buscar != null) {
            buscar = '%' + buscar + '%';
            rs = st.executeQuery("SELECT * FROM produtos where numero LIKE '" + buscar + "' order by numero asc");
        } else {
            rs = st.executeQuery("SELECT * FROM produtos order by numero asc");
        }

        while (rs.next()) {
            out.print("<td>" + rs.getString(2) + "</td>");
            out.print("<td>" + rs.getString(3) + "</td>");
            out.print("<td>R$ " + rs.getString(4).replace(".", ",") + "</td>");
            out.print("<td>" + rs.getString(5) + "</td>");
            out.print("<td> <img src='img/" + rs.getString(6) + "'width='40'></td>");

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
