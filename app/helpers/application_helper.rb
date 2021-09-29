module ApplicationHelper
    def active_or_inactive(controller  , current_path)
        cont, act =  current_path.split("_")
        if cont == controller.controller_name  and act == controller.action_name
            "active"
        else
            ""
        end
    end
end
