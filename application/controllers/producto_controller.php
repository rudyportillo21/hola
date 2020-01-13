<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class producto_controller extends CI_Controller {
	public function __construct(){
		parent::__construct();
		$this->load->model('producto_model');
	}

	public function index()
	{
		$data = array('title'=>'tienda || producto');
		$this->load->view('template/header',$data);
		$this->load->view('producto_view');
		$this->load->view('template/footer');
	}

	public function get_producto(){
		$respuesta =$this->producto_model->get_producto();
		echo json_encode($respuesta);
	}

	public function eliminar(){
		$id = $this->input->post('id');
		$respuesta =$this->producto_model->eliminar($id);
		echo json_encode($respuesta);
	}

	public function get_color(){
		$respuesta =$this->producto_model->get_color();
		echo json_encode($respuesta);
	}

	public function get_talla(){
		$respuesta =$this->producto_model->get_talla();
		echo json_encode($respuesta);
	}

	public function ingresar(){
		$datos['nombre'] = $this->input->post('nombre');
		$datos['color'] = $this->input->post('color');
		$datos['talla'] = $this->input->post('talla');

		$respuesta = $this->producto_model->set_producto($datos);
		echo json_encode($respuesta);

	}

	public function get_datos(){
		$id = $this->input->post('id');
		$respuesta =$this->producto_model->get_datos($id);
		echo json_encode($respuesta);
	}

	public function actualizar(){
		$datos['id_producto'] = $this->input->post('id_producto');
		$datos['nombre'] = $this->input->post('nombre');
		$datos['color'] = $this->input->post('color');
		$datos['talla'] = $this->input->post('talla');

		$respuesta = $this->producto_model->actualizar($datos);
		echo json_encode($respuesta);

	}
}
