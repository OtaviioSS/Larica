
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  


<jsp:include page="cabecalho.jsp"/>
<%String pag = "categorias";%>
<%String id_deletar = "";%>

<%
    Statement st = null;
    ResultSet rs = null;
%>

<div class="container mt-4">
    <div class="row mt-4 mb-4">
        <a type="button" class="btn-info btn-sm ml-3" href="<%= pag%>.jsp?funcao=novo">Nova Categoria</a>
        <form class="form-inline my-2 my-lg-0 direita" method="get">
            <input class="form-control form-control-sm mr-sm-2" type="search" id="txtbuscar" name="txtbuscar" placeholder="Buscar pelo Nome" aria-label="Search">
            <button class="btn btn-outline-info btn-sm my-2 my-sm-0 d-none d-md-block" type="submit" id="btn-buscar" name="btn-buscar">Buscar</button>
        </form>
    </div>

    <div id="listar">

    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modalDados" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">

                <%
                    String titulo = "";
                    String nome = "";
                    String descricao = "";
                    String imagem = "sem-foto.jpg";
                    String id = "";
                    if (request.getParameter(
                            "id") != null) {
                        titulo = "Editar Resgistro";

                        id = request.getParameter("id");
                        try {

                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM categorias where id = '" + id + "' ");
                            while (rs.next()) {
                                nome = rs.getString(2);
                                descricao = rs.getString(3);
                                imagem = rs.getString(4);

                            }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    } else {
                        titulo = "Inserir Resgistro";
                    }

                %>
                <h5 class="modal-title" id="exampleModalLabel"><%=titulo%></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="form" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputEmail4">Email</label>
                            <input type="email" class="form-control" id="txtemail" name="txtemail">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="validationCustom01">CPF</label>
                            <input type="text" class="form-control" id="txtcpf" name="txtcpf">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputAddress">Endereço</label>
                        <input type="text" class="form-control" id="txtendereco" name="txtendereco" placeholder="Rua da Saúde, Cajazeiras">
                    </div>
                    <div class="form-group">
                        <label for="inputAddress2">Nome</label>
                        <input type="text" class="form-control" id="txtnome" name="txtnome" placeholder="Tauane Souza">
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputCity">Cidade</label>
                            <input type="text" class="form-control" id="txtcidade" name="txtcidade">
                        </div>
                        <div class="form-group col-md-4">
                            <label for="validationCustom01">Telefone</label>
                            <input type="text" class="form-control" id="txttelefone" name="txttelefone">
                        </div>
                        <div class="form-group col-md-2">
                            <label for="inputZip">UF</label>
                            <input type="text" class="form-control" id="txtuf" name="txtuf">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlFile1">Imagem</label>
                        <input type="file" class="form-control-file" id="imagem" name="imagem[]" onchange="carregarImg();">
                        <!--carregarImg(), a funcão é chamada ao selecionar imagem-->
                    </div>
                    <img src="" alt="Imagem Carregada" id="target" width="150" height="150">

                    <div id="mensagem">

                    </div>

                </div>
                <div class="modal-footer">
                    <small>
                        <div  id="mensagem" class="mr-4">

                        </div>
                    </small>

                    <input value="<%=id%>" type="hidden" name="txtid" id="txtid">
                    <input value="<%=nome%>" type="hidden" name="antigo" id="antigo">

                    <button type="button" id="btn-fechar" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="submit" name="btn-salvar" id="btn-salvar" class="btn btn-primary">Salvar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal para excluir -->
<div class="modal" id="modal-deletar" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Excluir Registro</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <p>Deseja realmente Excluir este Registro?</p>

                <div align="center" id="mensagem_excluir" class="">

                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-cancelar-excluir">Cancelar</button>
                <form method="post">
                    <!--<%=id_deletar = request.getParameter("id")%>-->
                    <input type="hidden" id="id"  name="id" value="<%=id_deletar%>" required>

                    <button type="button" id="btn-deletar" name="btn-deletar" class="btn btn-danger">Excluir</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%    if (request.getParameter(
            "funcao") != null && request.getParameter("funcao").equals("novo")) {
        out.print("<script>$('#modalDados').modal('show');</script>");
    }

%>

<%    if (request.getParameter(
            "funcao") != null && request.getParameter("funcao").equals("editar")) {
        out.print("<script>$('#modalDados').modal('show');</script>");
    }

%>

<%    if (request.getParameter(
            "funcao") != null && request.getParameter("funcao").equals("excluir")) {

        out.print("<script>$('#modal-deletar').modal('show');</script>");
    }
%>

<!-- SCRIPT PARA SUBIR IMAGEM PARA O SERVIDOR -->
<script type="text/javascript">

    function carregarImg() {
        var pag = "<%=pag%>";
        var target = document.getElementById("target");
        var file = document.querySelector("input[type=file]").files[0];
        var reader = new FileReader();
        reader.onloadend = function () {
            target.src = reader.result;
        }
        ;
        if (file) {
            reader.readAsDataURL(file);
        } else {
            target.src = "";
        }

    }
</script>


<!--AJAX PARA INSERIR DADOS COM IMAGEM -->
<script type="text/javascript">
    $("#form").submit(function () {
        var pag = "<%=pag%>";
        event.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            url: pag + "/upload.jsp",
            type: 'POST',
            data: formData,
            success: function (mensagem) {

                $('#mensagem').removeClass()

                if (mensagem.trim() == 'Salvo com Sucesso!!') {

                    $('#mensagem').addClass('text-success')
                    $('#nome').val('');
                    $('#descricao').val('');

                    $('#btn-fechar').click();
                    $('#btn-buscar').click();

                } else {

                    $('#mensagem').addClass('text-danger')
                }

                $('#mensagem').text(mensagem)

            },

            cache: false,
            contentType: false,
            processData: false,
            xhr: function () {  // Custom XMLHttpRequest
                var myXhr = $.ajaxSettings.xhr();
                if (myXhr.upload) { // Avalia se tem suporte a propriedade upload
                    myXhr.upload.addEventListener('progress', function () {
                        /* faz alguma coisa durante o progresso do upload */
                    }, false);
                }
                return myXhr;
            }
        });
    });</script>
</script>

<!--AJAX PARA LISTAR OS DADOS -->
<script type="text/javascript">
    $(document).ready(function () {
        var pag = "<%=pag%>";
        $.ajax({
            url: pag + "/listar.jsp",
            method: "post",
            data: $('#frm').serialize(),
            dataType: "html",
            success: function (result) {
                $('#listar').html(result);
            }
        })

    })
</script>

<!--AJAX PARA BUSCAR DADOS PELO BOTÃO -->
<script type="text/javascript">

    $('#btn-buscar').click(function (event) {
        var pag = "<%=pag%>";
        event.preventDefault();
        $.ajax({
            url: pag + "/listar.jsp",
            method: "post",
            data: $('form').serialize(),
            dataType: "html",
            success: function (result) {
                $('#listar').html(result);
            }
        })
    })
</script>

<!--AJAX PARA BUSCAR DADOS PELA TXT -->
<script type="text/javascript">

    $('#txtbuscar').keyup(function () {
        $('#btn-buscar').click();
    })

</script>



<!--AJAX PARA EXCLUSÃO DOS DADOS -->
<script type="text/javascript">
    $(document).ready(function () {
        var pag = "<%=pag%>";
        $('#btn-deletar').click(function (event) {
            event.preventDefault();

            $.ajax({
                url: pag + "/excluir.jsp",
                method: "post",
                data: $('form').serialize(),
                dataType: "text",
                success: function (mensagem) {

                    if (mensagem.trim() == 'Excluído com Sucesso!!') {

                        $('#txtbuscar').val('')
                        $('#btn-buscar').click();
                        $('#btn-cancelar-excluir').click();

                    }
                },

            })
        })
    })
</script>

<jsp:include page="Rodape.jsp"/>

<!-- SCRIPT PARA FUNCIONAR O AJAX -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.js"></script>

