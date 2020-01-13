<?php $this->load->helper('producto'); ?>

<body class="container">
	<button type="button" class="btn btn-outline-success" id="nueProducto" style="margin:2px;">Nuevo Producto</button>
	<table border="1" class="table table-dark table-hover">
		<thead>
			<tr>
				<td>N°</td>
				<td>Nombre producto</td>
				<td>Color</td>
				<td>Talla</td>
				<td>Eliminar</td>
				<td>Editar</td>		
			</tr>
		</thead>
		<tbody id="tabla_productos">
			
		</tbody>
	</table>

	<div class="modal" tabindex="-1" role="dialog" id="modalBorrar">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title"></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>Esta seguro que quiere eliminar este producto?<br><p style="color:red;">Advertencia!!!... ESte acción no se podra deshacer!!!</p></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" id="btnBorrar">Si, Eliminar</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
					
				</div>
			</div>
		</div>
	</div>


	<div class="modal" tabindex="-1" role="dialog" id="modalProductos">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title"></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="formProducto" action="" method="POST">
						<input type="hidden" name="id_producto" id="id">
						<div>
							<label>Nombre de Producto</label>
							<input type="text" name="nombre" id="nombre" class="form-control text-center" placeholder="Ingrese el nombre del producto">
						</div>
						<div>
							<label>Color</label>
							<select id="color" name="color" class="form-control">
								
							</select>
							<div id="colores" style="font-family: Lucida Calligraphy; color: red; font-size: 75%;">
							</div>
						</div>
						<div>
							<label>Talla</label>
							<select id="talla" name="talla" class="form-control">
								
							</select>
							<div id="tallas" style="font-family: Lucida Calligraphy; color: red; font-size: 75%;">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="btnGuardar">Guardar</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
					
				</div>
			</div>
		</div>
	</div>