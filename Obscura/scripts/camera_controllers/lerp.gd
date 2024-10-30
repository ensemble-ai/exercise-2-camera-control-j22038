class_name Lerp
extends CameraControllerBase

@export var follow_speed:float = target.BASE_SPEED * 0.01
@export var catchup_speed:float = target.BASE_SPEED * 0.02
@export var leash_distance:float = 10.0


func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if !draw_camera_logic:
		draw_logic()
	
	var x_distance:float = target.global_position.x - global_position.x
	var z_distance:float = target.global_position.z - global_position.z
	var vessel_is_moving:bool = abs(target.velocity.x) > 0 or abs(target.velocity.z) > 0
	
	# if the distance between vessel and camera is greater than leash 
	# then follow speed and catchup speed are mulitiplied by 5

	if x_distance > 0 and vessel_is_moving:
		if follow_speed > abs(x_distance):
			global_position.x += x_distance
		if abs(x_distance) > leash_distance:
			global_position.x += follow_speed * 5
		else:
			global_position.x += follow_speed
		
	if x_distance < 0 and vessel_is_moving:
		if follow_speed > abs(x_distance):
			global_position.x -= x_distance
		if abs(x_distance) > leash_distance:
			global_position.x -= follow_speed * 5
		else:
			global_position.x -= follow_speed
		
	if z_distance > 0 and vessel_is_moving:
		if follow_speed > abs(z_distance):
			global_position.z += z_distance
		if abs(z_distance) > leash_distance:
			global_position.z += follow_speed * 5
		else:
			global_position.z += follow_speed
		
	if z_distance < 0 and vessel_is_moving:
		if follow_speed > abs(z_distance):
			global_position.z -= z_distance
		if abs(z_distance) > leash_distance:
			global_position.z -= follow_speed * 5
		else:
			global_position.z -= follow_speed

	if x_distance > 0 and not vessel_is_moving:
		if catchup_speed > abs(x_distance):
			global_position.x += x_distance
		if abs(x_distance) > leash_distance:
			global_position.x += catchup_speed * 5
		else:
			global_position.x += catchup_speed
	
	if x_distance < 0 and not vessel_is_moving:
		if catchup_speed > abs(x_distance):
			global_position.x -= x_distance
		if abs(x_distance) > leash_distance:
			global_position.x -= catchup_speed * 5
		else:
			global_position.x -= catchup_speed
		
	if z_distance > 0 and not vessel_is_moving:
		if catchup_speed > abs(z_distance):
			global_position.z += z_distance
		if abs(z_distance) > leash_distance:
			global_position.z += catchup_speed * 5
		else:
			global_position.z += catchup_speed
	
	if z_distance < 0 and not vessel_is_moving:
		if catchup_speed > abs(z_distance):
			global_position.z -= z_distance
		if abs(z_distance) > leash_distance:
			global_position.z -= catchup_speed * 5
		else:
			global_position.z -= catchup_speed
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -5.0
	var right:float = 5.0
	var top:float = -5.0
	var bottom:float = 5.0
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(left, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, bottom))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	await get_tree().process_frame
	mesh_instance.queue_free()
