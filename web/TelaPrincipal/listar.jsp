<% String buscar = request.getParameter("txtbuscar"); %>
<% String nomeCat = ""; %>
<% String pag = "telaPagamento"; %>

<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  
<%
    Statement st, st2 = null;
    ResultSet rs, rs2 = null;
%>

<div class="container mt-4">
    <% out.print(" <table class='table table-sm table-striped' style='font-size: 11px'>"
                + "<thead>"
                + "<tr>"
                + "<th scope='col'>Nome Cliente</th>"
                + "<th scope='col'>Produto</th>"
                + "<th scope='col'>Endereço</th>"
                + "<th scope='col'>Quantidade</th>"
                + "<th scope='col'>Forma de Pagamento</th>"
                + "<th scope='col'>Valor Total</th>"
                + "<th scope='col'>Ações</th>"
                + "</tr>"
                + "</thead>"
                + "<tbody>");

        try {

            st = new Conexao().conectar().createStatement();
            st2 = new Conexao().conectar().createStatement();

            if (buscar != null) {
                buscar = '%' + buscar + '%';
                rs = st.executeQuery("SELECT * FROM carrinho where nomecliente LIKE '" + buscar + "' order by nomecliente asc");
            } else {
                rs = st.executeQuery("SELECT * FROM carrinho order by nomecliente asc");
            }

            int qtd = 0;
            double valor = 0;
            double valorTotal = 0;

            while (rs.next()) {

                qtd = Integer.parseInt(rs.getString(7));
                valor = Double.parseDouble(rs.getString(6));

                valorTotal = qtd * valor;

                out.print("<td>" + rs.getString(2) + "</td>");
                out.print("<td>" + rs.getString(3) + "</td>");
                out.print("<td>" + rs.getString(4) + "</td>");
                out.print("<td>" + rs.getString(7) + "</td>");
                out.print("<td>" + rs.getString(5) + "</td>");
                out.print("<td>R$ " + valorTotal + "</td>");

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