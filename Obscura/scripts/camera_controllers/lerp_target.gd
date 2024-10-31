class_name LerpTarget
extends CameraControllerBase

const left:float = -5.0
const right:float = 5.0
const top:float = -5.0
const bottom:float = 5.0
@export var lead_speed:float = target.BASE_SPEED * 0.03
@export var catchup_delay_duration:float = 0.5
@export var catchup_speed:float = target.BASE_SPEED * 0.02
@export var leash_distance:float = 10.0
var _timer:Timer

func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if !draw_camera_logic:
		draw_logic()

	var left_edge_pos:float = global_position.x - leash_distance
	var right_edge_pos:float = global_position.x + leash_distance
	var top_edge_pos:float = global_position.z - leash_distance
	var bottom_edge_pos:float = global_position.z + leash_distance
	
	var x_distance:float = global_position.x - target.global_position.x
	var z_distance:float = global_position.z - target.global_position.z
	var vessel_is_moving:bool = abs(target.velocity.x) > 0 or abs(target.velocity.z) > 0
	
	if target.velocity.x > 0:
		if abs(x_distance) > leash_distance:
			target.global_position.x = left_edge_pos
		global_position.x += lead_speed
		
	if target.velocity.x < 0:
		if abs(x_distance) > leash_distance:
			target.global_position.x = right_edge_pos
		global_position.x -= lead_speed
	
	if target.velocity.z > 0:
		if abs(z_distance) > leash_distance:
			target.global_position.z = top_edge_pos
		global_position.z += lead_speed
		
	if target.velocity.z < 0:
		if abs(z_distance) > leash_distance:
			target.global_position.z = bottom_edge_pos
		global_position.z -= lead_speed
		
	if not vessel_is_moving and _timer == null:
		_timer = Timer.new()
		add_child(_timer)
		_timer.one_shot = true
		_timer.start(catchup_delay_duration)
		
	if _timer != null and _timer.is_stopped():
		if x_distance > 0 and not vessel_is_moving:
			if catchup_speed > abs(x_distance):
				target.global_position.x += x_distance
			if abs(x_distance) > leash_distance:
				target.global_position.x = left_edge_pos
			target.global_position.x += catchup_speed
		
		if x_distance < 0 and not vessel_is_moving:
			if catchup_speed > abs(x_distance):
				target.global_position.x -= x_distance
			if abs(x_distance) > leash_distance:
				target.global_position.x = right_edge_pos
			target.global_position.x -= catchup_speed
			
		if z_distance > 0 and not vessel_is_moving:
			if catchup_speed > abs(z_distance):
				target.global_position.z += z_distance
			if abs(z_distance) > leash_distance:
				target.global_position.z = top_edge_pos
			target.global_position.z += catchup_speed
		
		if z_distance < 0 and not vessel_is_moving:
			if catchup_speed > abs(z_distance):
				target.global_position.z -= z_distance
			if abs(z_distance) > leash_distance:
				target.global_position.z = bottom_edge_pos
			target.global_position.z -= catchup_speed
				
	if x_distance == 0 and z_distance == 0 and _timer != null:
		_timer.queue_free()

	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
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
