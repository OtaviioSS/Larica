<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% String pag = "usuarios.jsp"; %>
<!DOCTYPE html>
<html>
    <head>

        <jsp:include page="cabecalho.jsp"/>

        <title>Lista de usuários</title>
    </head>
    <body>

        <%
            Statement st = null;
            ResultSet rs = null;
        %>
        <div class="container-fluid">

        </div>



        <div class="container">
            <div class="row mt-4 mb-4">
                <a type="button" class="btn-info btn-sm" href="usuarios.jsp?funcao=novo">Novo Usuário</a>
                <!-- <form class="form-inline my-2 my-lg-0 direita" method="get">
                     <input class="form-control form-control-sm mr-sm-2" type="search" name="txtbuscar" placeholder="Buscar pelo Nome" aria-label="Search">
                     <button class="btn btn-outline-info btn-sm my-2 my-sm-0" type="submit" id="btn-buscar" name="btn-buscar">Buscar</button>
                 </form>-->
            </div>

            <!-- <table class="table table-striped table-sm table-dark"  style=" font-size: 11px">
                 <thead>
                     <tr>
                         <th scope="col">Nome</th>
                         <th scope="col">Usuário</th>
                         <th scope="col">Senha</th>
                         <th scope="col">Nível</th>
                         <th scope="col">Ações</th>
                     </tr>
                 </thead>
                 <tbody>
 
            <%                                            try {

                    st = new Conexao().conectar().createStatement();
                    if (request.getParameter("btn-buscar") != null) {
                        String buscar = '%' + request.getParameter("txtbuscar") + '%';
                        rs = st.executeQuery("SELECT * FROM usuarios where nome LIKE '" + buscar + "' order by nome asc");
                    } else {
                        rs = st.executeQuery("SELECT * FROM usuarios order by nome asc");
                    }

                    while (rs.next()) {%>

            <tr>
                <td><%= rs.getString(2)%></td>
                <td><%= rs.getString(3)%></td>
                <td><%= rs.getString(4)%></td>
                <td><%= rs.getString(5)%></td>
                <td>
                    <a href="<%=pag%>?funcao=editar&id=<%= rs.getString(1)%>" class="text-info"><i class="far fa-edit"></i></a>
                    <a href="<%=pag%>?funcao=excluir&id=<%= rs.getString(1)%>" class="text-danger"><i class="far fa-trash-alt"></i></i></a>
                </td>
            </tr>


            <% }
                } catch (Exception e) {
                    out.print(e);
                }

            %>



        </tbody>
    </table>
</div> 

            -->




    </body>
</html>




<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <%  String titulo = "";
                    String btn = "";
                    String xid = "";
                    String xnome = "";
                    String xusuario = "";
                    String xsenha = "";
                    String xnivel = "Selecione um Nível";
                    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
                        titulo = "Editar Usuário";
                        btn = "btn-editar";
                        xid = request.getParameter("id");
                        try {
                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM usuarios where id = '" + xid + "' ");
                            while (rs.next()) {
                                xnome = rs.getString(2);
                                xusuario = rs.getString(3);
                                xsenha = rs.getString(4);
                                xnivel = rs.getString(5);

                            }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    } else {
                        titulo = "Inserir Usuário";
                        btn = "btn-salvar";
                    }
                %>
                <h5 class="modal-title" id="exampleModalLabel"><%=titulo%></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="cadastro-form" class="form" action="" method="post">
                <div class="modal-body">

                    <input value="<%=xusuario%>" type="hidden" name="txtantigo" id="txtantigo">

                    <div class="form-group">
                        <label for="username" >Nome</label><br>
                        <input value="<%=xnome%>" type="text" name="txtnome" id="txtnome" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="username" >Usuário</label><br>
                        <input value="<%=xusuario%>" type="text" name="txtusuario" id="txtusuario" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Senha</label><br>
                        <input value="<%=xsenha%>" type="text" name="txtsenha" id="txtsenha" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlSelect2">Nível</label>
                        <select class="form-control" name="txtnivel" id="txtnivel" required>
                            <option value="<%=xnivel%>"><%=xnivel%></option>
                            <%
                                if (!xnivel.equals("Comum")) {
                                    out.print(" <option>Comum</option>");
                                }
                                if (!xnivel.equals("Admin")) {
                                    out.print(" <option>Admin</option>");
                                }


                            %>

                        </select>
                    </div>



                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                    <button type="submit" name="<%=btn%>" class="btn btn-primary"><%=titulo%></button>
                </div>
            </form>
        </div>
    </div>
</div>


<%

    if (request.getParameter(
            "btn-salvar") != null) {

        String usuario = request.getParameter("txtusuario");
        String senha = request.getParameter("txtsenha");
        String nivel = request.getParameter("txtnivel");
        String nome = request.getParameter("txtnome");

        try {

            st = new Conexao().conectar().createStatement();
            rs = st.executeQuery("SELECT * FROM usuarios where usuario = '" + usuario + "'");
            while (rs.next()) {
                rs.getRow();
                if (rs.getRow() > 0) {
                    out.print("<script>alert('Usuário Já Cadastrado!');</script>");
                    return;
                }
            }
            st.executeUpdate("INSERT into usuarios (nome, usuario, senha, nivel) values ('" + nome + "', '" + usuario + "', '" + senha + "', '" + nivel + "')");
            response.sendRedirect(pag);
        } catch (Exception e) {
            out.print(e);
        }
    }
%>



<%
    if (request.getParameter(
            "funcao") != null && request.getParameter("funcao").equals("excluir")) {
        String id = request.getParameter("id");

        try {
            st = new Conexao().conectar().createStatement();
            st.executeUpdate("DELETE from usuarios where id = '" + id + "'");

            response.sendRedirect(pag);
        } catch (Exception e) {
            out.print(e);
        }
    }

%>


<%    if (request.getParameter(
            "funcao") != null && request.getParameter("funcao").equals("editar")) {
        out.print("<script>$('#modal').modal('show');</script>");
    }

%>


<%    if (request.getParameter(
            "funcao") != null && request.getParameter("funcao").equals("novo")) {
        out.print("<script>$('#modal').modal('show');</script>");
    }

%>



<%                                  if (request.getParameter(
            "btn-editar") != null) {
        String usuario = request.getParameter("txtusuario");
        String senha = request.getParameter("txtsenha");
        String nivel = request.getParameter("txtnivel");
        String nome = request.getParameter("txtnome");
        String id = request.getParameter("id");
        String antigo = request.getParameter("txtantigo");

        try {

            st = new Conexao().conectar().createStatement();
            if (!antigo.equals(usuario)) {
                rs = st.executeQuery("SELECT * FROM usuarios where usuario = '" + usuario + "'");
                while (rs.next()) {
                    rs.getRow();
                    if (rs.getRow() > 0) {
                        out.print("<script>alert('Usuário Já Cadastrado!');</script>");
                        return;
                    }
                }
            }
            st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', usuario = '" + usuario + "', senha = '" + senha + "', nivel = '" + nivel + "' where id = '" + id + "'");
            response.sendRedirect(pag);
        } catch (Exception e) {
            out.print(e);
        }
    }
%>

<script type="text/javascript">
    $(document).ready(function () {

        $('#btn-buscar').click(function () {
            console.log("Teste");
        })
    })
</script>



<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.js"></script>