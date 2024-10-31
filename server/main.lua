lib.versionCheck('PFScripts/pf_management')

-- [ Functions ] --

---@param src number
local function groupCreator(src, _ , _)
  local data = lib.callback.await('pf_management:client:groupCreator', src, false)
  if type(data) == 'boolean' then return end
  Ox.CreateGroup(data)
end

---@param args table
local function groupDeleter(_, args, _)
  local account = Ox.GetGroupAccount(args.groupName)
  if type(account) == 'nil' then Ox.DeleteGroup(args.groupName) return end
  account.deleteAccount()
  if type(args.deleteAccount) == 'nil' then return end
  MySQL.scalar.await('DELETE FROM accounts WHERE id = ?', {account.accountId})
end

-- [ Commands ] --

lib.addCommand('groupCreator', {help = 'Creates a new group', restricted = 'group.admin'}, groupCreator)
lib.addCommand('groupDeleter', {help = 'Deletes an existing group', params = {
  {name = 'groupName', type = 'string', help = 'This should be the group NAME not the LABEL'},
  {name = 'deleteAccount', help = 'You should write anything on this arg otherwise it ill not work (optional)', optional = true}
}, restricted = 'group.admin'}, groupDeleter)