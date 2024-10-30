class_name FourWaySpeedup
extends CameraControllerBase

@export var push_ratio:float = 0.015
@export var pushbox_top_left:Vector2 = Vector2(-8.0, -8.0)
@export var pushbox_bottom_right:Vector2 = Vector2(8.0, 8.0)
@export var speedup_zone_top_left:Vector2 = Vector2(-4.0, -4.0)
@export var speedup_zone_bottom_right:Vector2 = Vector2(4.0, 4.0)


func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()

	var inner_left_edge_pos:float = global_position.x + speedup_zone_top_left.y
	var inner_right_edge_pos:float = global_position.x + speedup_zone_bottom_right.y
	var inner_top_edge_pos:float = global_position.z + speedup_zone_top_left.x
	var inner_bottom_edge_pos:float = global_position.z + speedup_zone_bottom_right.x

	var outer_left_edge_pos:float = global_position.x + pushbox_top_left.y
	var outer_right_edge_pos:float = global_position.x + pushbox_bottom_right.y
	var outer_top_edge_pos:float = global_position.z + pushbox_top_left.x
	var outer_bottom_edge_pos:float = global_position.z + pushbox_bottom_right.x
	
	var in_inner_box:bool = (
		target.global_position.x > inner_left_edge_pos 
		and target.global_position.x < inner_right_edge_pos
		and target.global_position.z > inner_top_edge_pos
		and target.global_position.z < inner_bottom_edge_pos
	)
	
	var in_speedup_zone_x:bool = (
		not in_inner_box
		and target.global_position.x > outer_left_edge_pos 
		and target.global_position.x < outer_right_edge_pos
	)
	
	var in_speedup_zone_z:bool = (
		not in_inner_box
		and target.global_position.z > outer_top_edge_pos
		and target.global_position.z < outer_bottom_edge_pos
	)
	
	if in_speedup_zone_x and abs(target.velocity.x) > 0:
		global_position.x += target.velocity.x * push_ratio
			
	if in_speedup_zone_z and abs(target.velocity.z) > 0:
		global_position.z += target.velocity.z * push_ratio
		
	# use code from push_box.gd
	
	var tpos = target.global_position
	var cpos = global_position
	var box_width = abs(pushbox_top_left.y) * 2
	var box_height = abs(pushbox_top_left.x) * 2

	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - box_width / 2.0)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges

	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + box_width / 2.0)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges

	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - box_height / 2.0)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges
		
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + box_height / 2.0)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges

	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = pushbox_top_left.y
	var right:float = pushbox_bottom_right.y
	var top:float = pushbox_top_left.x
	var bottom:float = pushbox_bottom_right.x
	
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
