DELIMITER $$
CREATE TRIGGER update_editor
AFTER INSERT ON `users_nodes` FOR EACH ROW
   UPDATE Nodes
     SET editor_id = NEW.users_id
   WHERE id = NEW.nodes_id;
$$
DELIMITER ;