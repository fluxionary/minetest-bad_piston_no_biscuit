minetest.log('action', '[bad_piston_no_biscuit] initializing')

local patterns = {
    '3d_armor_stand:.*',
    'areasprotector:.*',
    'chesttools:shared_chest',
    'currency:.*',
    'doors:.*prison.*',
    'doors:.*steel.*',
    'gravelsieve:.*',
    'homedecor:.*_locked',
    'inbox:.*',
    'mailbox:.*',
    'maptools:.*',
    'mesecons_commandblock:.*',
    'nether:bedrock',
    'smartline:.*',
    'smartrenting:.*',
    'smartshop:.*',
    'technic:.*_locked_chest',
    'techpack_warehouse:.*',
    'terumet:mach_.*',
    'travelnet:.*',
    'tubelib.*:.*',
    'xdecor:mailbox',
}

function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0 -- iterator variable
    return function() -- iterator function
        i = i + 1

        if a[i] == nil then
            return nil

        else
            return a[i], t[a[i]]
        end
    end
end

for node_name, _ in pairsByKeys(minetest.registered_nodes) do
    for _, pattern in pairs(patterns) do
        local fullpattern = '^' .. pattern .. '$'
        if string.find(node_name, fullpattern) then
            minetest.log('action', '[bad_piston_no_biscuit] registering ' .. node_name)
            mesecon.register_mvps_stopper(node_name)
            break
        end
    end
end
