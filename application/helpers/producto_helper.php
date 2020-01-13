<script>
	//inicio de estructura ajax
	$(document).ready(function(){
		mostrarProductos();

		function mostrarProductos(){
			$.ajax({
				type: 'ajax',
				url: '<?= base_url('producto_controller/get_producto') ?>',
				dataType: 'json',

				success: function(datos){
					var tabla = '';
					var i;
					var n=1;

					for (i = 0; i < datos.length; i++) {
						tabla+=
						'<tr>'+
						'<td>'+n+'</td>'+
						'<td>'+datos[i].nombre_producto+'</td>'+
						'<td>'+datos[i].nombre_color+'</td>'+
						'<td>'+datos[i].nombre_talla+'</td>'+
						'<td>'+'<a href="javascript:;" class="btn btn-danger borrar" data="'+datos[i].id_producto+'">ELIMINAR</a>'+'</td>'+
						'<td>'+'<a href="javascript:;" class="btn btn-primary editar" data="'+datos[i].id_producto+'">EDITAR</a>'+'</td>'+
						'</tr>';
						n++;
					}
					$('#tabla_productos').html(tabla);
				}
			});
		};//fin de la funcion mostrarProductos


		$('#tabla_productos').on('click','.borrar',function(){//inicio de la funcion eliminar
			$id = $(this).attr('data');
			$('#modalBorrar').modal('show');
			$('#modalBorrar').find('.modal-title').text('Eliminar producto');

			$('#btnBorrar').unbind().click(function(){
				$.ajax({
					type: 'ajax',
					method: 'post',
					url: '<?= base_url('producto_controller/eliminar') ?>',
					data:{id:$id},
					dataType: 'json',

					success: function(respuesta){
						$('#modalBorrar').modal('hide');

						if(respuesta==true){
							alertify.notify('Eliminado exitosamente','success',10,null);
							mostrarProductos();
						}else{
							alertify.notify('Error al eliminar','error',10,null);
						}
					},
					error: function(){
						alertify.notify('Error al eliminar, registro dependiente!!!','error',10,null);
						mostrarProductos();
					}
				});
			});
		});//fin de la funcion eliminar

		get_color();

		function get_color(){
			$.ajax({
				type: 'ajax',
				url: '<?= base_url('producto_controller/get_color') ?>',
				dataType: 'json',

				success: function(datos){
					var op ='';
					var i;

					op+="<option value=''>Seleccione el color</option>";


					for (i = 0; i < datos.length; i++) {
						op+="<option value='"+datos[i].id_color+"'>"+datos[i].nombre_color+"</option>";
					}

					$('#color').html(op);
				}
			});
		}


		get_talla();

		function get_talla(){
			$.ajax({
				type: 'ajax',
				url: '<?= base_url('producto_controller/get_talla') ?>',
				dataType: 'json',

				success: function(datos){
					var op ='';
					var i;

					op+="<option value=''>Seleccione el talla</option>";


					for (i = 0; i < datos.length; i++) {
						op+="<option value='"+datos[i].id_talla+"'>"+datos[i].nombre_talla+"</option>";
					}

					$('#talla').html(op);
				}
			});
		}

		$('#nueProducto').click(function(){
			$('#modalProductos').modal('show');
			$('#modalProductos').find('.modal-title').text('Nuevo producto');
			$('#formProducto').attr('action','<?= base_url('producto_controller/ingresar') ?>');
		});

		$('#btnGuardar').click(function(){
			$resultado = validarFormulario();
			if($resultado==true){
				$url = $('#formProducto').attr('action');
				$data = $('#formProducto').serialize();


				$.ajax({
					type: 'ajax',
					method: 'post',
					url: $url,
					data: $data,
					dataType: 'json',

					success: function(respuesta){
						$('#modalProductos').modal('hide');

						if(respuesta=='add'){
							alertify.notify('Ingresado exitosamente','success',10,null);
							mostrarProductos();
						}else if(respuesta=='edi'){
							alertify.notify('Actualizado exitosamente','success',10,null);
						}else{
							alertify.notify('Error al ingresar','error',10,null);
						}

						$('#formProducto')[0].reset();
					}
				});

			}
		});


		$('#tabla_productos').on('click','.editar',function(){//inicio de la funcion eliminar

			$id = $(this).attr('data');
			$('#modalProductos').modal('show');
			$('#modalProductos').find('.modal-title').text('Actualizar producto');
			$('#formProducto').attr('action','<?= base_url('producto_controller/actualizar') ?>');

			$.ajax({
				type: 'ajax',
				method: 'post',
				url: '<?= base_url('producto_controller/get_datos') ?>',
				data:{id:$id},
				dataType: 'json',

				success: function(datos){
					$('#id').val(datos.id_producto);
					$('#nombre').val(datos.nombre_producto);
					$('#color').val(datos.id_color);
					$('#talla').val(datos.id_talla);

				}
			});

		});//fin de la funcion eliminar

		function validarFormulario(){
			$nombre = $('#nombre').val();
			$color = $('#color').val();
			$talla = $('#talla').val();
			

			

			if($nombre.length == 0){
				$("#nombre").css('borderColor', 'red');
				$("#nombre").css('boxShadow', '0 0 5px red');
				$("#nombre").attr('placeholder', 'Campo Obligatorio');
				return false;
			}else{
				$("#nombre").css('borderColor', 'green');
				$("#nombre").css('boxShadow', '0 0 5px green');

			}

			if($color.length==''){
				$("#color").css('borderColor', 'red');
				$("#color").css('boxShadow', '0 0 5px red');
				$("#colores").text('Seleccione un color');
				return false;
			}else{
				$("#color").css('borderColor', 'green');
				$("#color").css('boxShadow', '0 0 5px green');
				$("#colores").text('');

			}

			

			if($talla.length==''){
				$('#talla').css('borderColor','red');
				$('#talla').css('boxShadow','0 0 5px red');
				$("#tallas").text('Seleccione una talla');
				return false;
			}else{
				$('#talla').css('borderColor','green');
				$('#talla').css('boxShadow','0 0 5px green');
				$("#tallas").text('');
			}



			return true;
		};



	});//fin de estructura ajax

</script>