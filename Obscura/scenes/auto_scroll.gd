class_name AutoScroll
extends CameraControllerBase

@export var top_left:Vector2 = Vector2(-5, -5)
@export var bottom_right:Vector2 = Vector2(5, 5)
@export var autoscroll_speed:Vector3 = Vector3(0.5, 0, 0)


func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
		
	var left_edge_pos:float = global_position.x + top_left.y
	var right_edge_pos:float = global_position.x + bottom_right.y
	var top_edge_pos:float = global_position.z + top_left.x
	var bottom_edge_pos:float = global_position.z + bottom_right.x
	
	if target.global_position.x < left_edge_pos:
		target.global_position.x = left_edge_pos
	
	if target.global_position.x > right_edge_pos:
		target.global_position.x = right_edge_pos
		
	if target.global_position.z > bottom_edge_pos:
		target.global_position.z = bottom_edge_pos
		
	if target.global_position.z < top_edge_pos:
		target.global_position.z = top_edge_pos
	
	global_position += autoscroll_speed
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = top_left.y
	var right:float = bottom_right.y
	var top:float = top_left.x
	var bottom:float = bottom_right.x
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	await get_tree().process_frame
	mesh_instance.queue_free()
	