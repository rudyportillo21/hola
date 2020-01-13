<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class producto_model extends CI_Model {
	public function get_producto(){
		$pa_mostrarProductos = "CALL pa_mostrarProductos()";
		$query = $this->db->query($pa_mostrarProductos);
		if($query->num_rows()>0){
			return $query->result();
		}else{
			return FALSE;
		}
	}

	public function eliminar($id){
		$pa_eliminarProducto = "CALL pa_eliminarProducto(?)";
		$arreglo = array('id_producto'=>$id);
		$query = $this->db->query($pa_eliminarProducto,$arreglo);
		if($query){
			return true;
		}else{
			return false;
		}
	}

	public function get_color(){
		$exe= $this->db->get('color');
		return $exe->result();
	}

	public function get_talla(){
		$exe = $this->db->get('talla');
		return $exe->result();
	}

	public function set_producto($datos){
		$pa_insertarProducto = "CALL pa_insertarProducto(?,?,?)";
		$arreglo = array('nombre_producto'=>$datos['nombre'],
			'id_color'=>$datos['color'],
			'id_talla'=>$datos['talla']);
		$query = $this->db->query($pa_insertarProducto,$arreglo);
		if($query!==null){
			return "add";
		}
	}

	public function get_datos($id){
		$pa_mostrarProductoId = "CALL pa_mostrarProductoId(?)";
		$arreglo = array('id_producto'=>$id);
		$query = $this->db->query($pa_mostrarProductoId,$arreglo);
		if($query->num_rows()>0){
			return $query->row();
		}else{
			return false;
		}
	}

	public function actualizar($datos){
		$pa_editartarProducto = "CALL pa_editarProducto(?,?,?,?)";
		$arreglo = array('id_producto'=>$datos['id_producto'],
			'nombre_producto'=>$datos['nombre'],
			'id_color'=>$datos['color'],
			'id_talla'=>$datos['talla']);
		$query = $this->db->query($pa_editartarProducto,$arreglo);
		if($query){
			return "edi";
		}
	}

}
