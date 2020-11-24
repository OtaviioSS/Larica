<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  
<%String pag = "TelaPrincipal";%>

<%
    Statement st = null;
    ResultSet rs = null;
%>
<%String nomeCat = "";%>
<%String vlrCat = "";%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>TelaPrincipal</title>
        <jsp:include page="cabecalho.jsp"/>
    </head>
    <body>

        <div class="container mt-3">
            <div class="row">
                <div class="col-12">
                    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carouselExampleControls" data-slide-to="0" class="active"></li>
                            <li data-target="#carouselExampleControls" data-slide-to="1"></li>
                            <li data-target="#carouselExampleControls" data-slide-to="2"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img class="d-block w-100" src="images/FrangoGrelhado.jpg" alt="First slide">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Frango Grelhado</h5>
                                    <spann>R$: 30,00</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="images/Sanduíche.jpg" alt="Second slide">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Sanduíche</h5>
                                    <p>R$: 15,00</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="images/Sopa.jpg" alt="Third slide">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Sopa</h5>
                                    <p>R$: 10,00</p>
                                </div>
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
            </div>
            <hr>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-4">
                    <div class="row">
                        <div class="col-2"><img class="rounded-circle" alt="Free Shipping" src="images/WhatsappBlack.png"></div>
                        <div class="col-lg-6 col-10 ml-1">
                            <h4>99242-4594</h4>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="row">
                        <div class="col-2"><img class="rounded-circle" alt="Free Shipping" src="images/FacebookBlack.png"></div>
                        <div class="col-lg-6 col-10 ml-1">
                            <h4>L@rica</h4>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="row">
                        <div class="col-2"><img class="rounded-circle" alt="Free Shipping" src="images/InstagramBlack.png"></div>
                        <div class="col-lg-6 col-10 ml-1">
                            <h4>L@rica</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <h2 class="text-center">Produtos Recomendados</h2>
        <hr>
        <div class="container">
            <div class="row text-center">
                <div class="col-md-4 pb-1 pb-md-0">
                    <div class="card">
                        <img class="card-img-top" src="images/Massa.png" alt="Card image cap">
                        <div class="card-body">
                            <h5 class="card-title">Macarrão Penne</h5>
                            <p class="card-text">Macarrão penne em molho de tomate com frango e tomate em uma mesa de madeira</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 pb-1 pb-md-0">
                    <div class="card">
                        <img class="card-img-top" src="images/PeitoECostela.png" alt="Card image cap">
                        <div class="card-body">
                            <h5 class="card-title">Frango c/ Costeleta</h5>
                            <p class="card-text">Peito de frango e costeleta de porco com bife de carne e vegetais.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 pb-1 pb-md-0">
                    <div class="card">
                        <img class="card-img-top" src="images/Lancheira.png" alt="Card image cap">
                        <div class="card-body">
                            <h5 class="card-title">Lancheira de frango</h5>
                            <p class="card-text">Lancheira de frango, bulgur, microgreens, tomate e frutas. comida saudável fitness.</p>
                        </div>
                    </div>
                </div>
            </div>
            <center><a type="button" class="btn-info btn mt-4" href="<%= pag%>.jsp?funcao=novo">Comprar</a></center>
        </div>
    </body>

    <!-- Modal -->
    <div class="modal fade" id="modalDados" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">

                    <%
                        String titulo = "";
                        String nome = "";
                        String endereco = "";
                        String forma = "";
                        String nomeProduto = "";
                        String valorProduto = "";
                        String qtd = "";
                        String id = "";
                        if (request.getParameter(
                                "id") != null) {
                            titulo = "Editar Resgistro";

                            id = request.getParameter("id");
                            try {

                                // Campo editar, trás os campos preenchidos para os inputs
                                st = new Conexao().conectar().createStatement();
                                rs = st.executeQuery("SELECT * FROM carrinho where id = '" + id + "' ");

                                while (rs.next()) {
                                    nome = rs.getString(2);
                                    endereco = rs.getString(3);
                                    forma = rs.getString(4);

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
                        <div class="form-group">
                            <label>Selecione o Produto</label>
                            <select  class="form-control form-control-sm" id="nomeProduto" name="nomeProduto" >
                                <!-- -->
                                <%
                                    // Recuperar o nome do campo para mostrar de inicio no select 
                                    if (!nomeProduto.equals("")) {
                                        rs = st.executeQuery("SELECT * FROM produtos where id = '" + nomeProduto + "'");

                                        while (rs.next()) {
                                            nomeCat = rs.getString(2);
                                        }
                                        out.print("<option  value ='" + nomeProduto + "'>" + nomeCat + "</option >");

                                    }

                                    st = new Conexao().conectar().createStatement();
                                    rs = st.executeQuery("SELECT * FROM produtos order by nome asc");

                                    while (rs.next()) {
                                        if (!nomeCat.equals(rs.getString(2))) {
                                            out.print("<option onclick='reload()'  value ='" + rs.getString(2) + "'>" + rs.getString(2) + "</option >");
                                        }

                                    }
                                %>
                                <option value=""></option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Nome Cliente</label>
                            <input value="<%=nome%>" type="text" class="form-control" id="nome" name="nome" placeholder="Tauane Souza">
                        </div>

                        <div class="form-group">
                            <label>Endereço</label>
                            <input value="<%=endereco%>" type="text" class="form-control" id="endereco" name="endereco" placeholder="Alphaville,242">
                        </div>

                        <div class="form-group">
                            <label>Quantidade</label>
                            <input  value="<%=qtd%>" type="text" class="form-control" id="qtd" name="qtd" placeholder="Quantidade">
                        </div>

                        <div class="form-group">
                            <label>Forma de Pagamento</label>
                            <input  value="<%=forma%>" type="text" class="form-control" id="forma" name="forma" placeholder="FormaPagamento">
                        </div>

                        <div class="form-group">
                            <label>Valor</label>
                            <select  class="form-control form-control-sm" name="vlrTotal" id="vlrTotal">

                                <%
                                    // Recuperar o nome do campo para mostrar de inicio no select 
                                    if (!nomeProduto.equals("")) {
                                        rs = st.executeQuery("SELECT DISTINCT preco from produtos where nome = '" + nomeProduto + "'");

                                        while (rs.next()) {
                                            vlrCat = rs.getString(4);
                                        }
                                        //out.print("<option value ='" + valorProduto + "'>" + vlrCat + "</option >");
                                    }

                                    st = new Conexao().conectar().createStatement();
                                    rs = st.executeQuery("SELECT * FROM produtos order by nome asc");

                                    while (rs.next()) {
                                        if (!vlrCat.equals(rs.getString(4))) {

                                        }
                                        out.print("<option value ='" + rs.getString(4) + "'>" + rs.getString(4) + "</option >");
                                    }


                                %>
                                <!--<option value=""></option>-->
                            </select>
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

    <%
        if (request.getParameter(
                "funcao") != null && request.getParameter("funcao").equals("novo")) {
            out.print("<script>$('#modalDados').modal('show');</script>");
        }

    %>
    <script>
        function reload() {
            var container = document.getElementById("vlrTotal");
            container = document.location.reload(true);

            //this line is to watch the result in console , you can remove it later
            console.log("Refreshed");
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
                        $('#endereco').val('');
                        $('#forma').val('');

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



    <hr>
    <div style="margin-top: -470px"> 
        <jsp:include page="Rodape.jsp"/>
    </div>
</html>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.js"></script>