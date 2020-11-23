<%-- 
    Document   : TelaPagamento
    Created on : 31/10/2020, 15:47:27
    Author     : CJads
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrinho</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
    </head>
    <jsp:include page="cabecalho.jsp"/>


    <%@page import="java.sql.*"%>
    <%@page import="com.mysql.jdbc.Driver"%>
    <%@page import="util.Conexao"%>  

    <% String pag = "TelaPagamento"; %>
    <% String buscar = request.getParameter("txtbuscar"); %>
    <% String nomeCat = ""; %>
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


    <div class="container mb-4" style="margin-top: 120px">

        <hr>
        <div class="btn-group-sm mb-4">

            <div class="dropdown-menu">
                <a class="dropdown-item" href="#"></a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Dinheiro</a>
                <a class="dropdown-item" href="#">Cartão</a>
            </div>
        </div>

        <span><button type="button" class="btn btn-danger">Cancelar</button></span>
        <span style="margin-left: 920px"><button type="button" class="btn btn-success">Finalizar</button></span>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

    <jsp:include page="Rodape.jsp"/>
</html>
