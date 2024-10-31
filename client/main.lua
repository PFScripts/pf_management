-- [ Functions ] --

---@return table | boolean
local function groupCreator()
  local groupInputDialog = lib.inputDialog(locale('groupInputDialog.heading'), {
    {type = 'input', label = locale('groupInputDialog.rows.groupName'), required = true},
    {type = 'input', label = locale('groupInputDialog.rows.groupLabel'), required = true},
    {type = 'number', label = locale('groupInputDialog.rows.groupGrades'), min = 1, required = true},
    {type = 'input', label = locale('groupInputDialog.rows.groupType'), required = false},
    {type = 'checkbox', label = locale('groupInputDialog.rows.groupHasAccount'), required = false}
  })
  if not groupInputDialog then return false end
  local groupGrades = {}
  for i = 1, groupInputDialog[3] do
    local groupGradeInputDialog = lib.inputDialog(locale('GradeInputDialog.heading', groupInputDialog[2], i), {
      {type = 'input', label = locale('GradeInputDialog.rows.gradeName'), required = true},
      {type = 'select', label = locale('GradeInputDialog.rows.gradeAccountRole'), options = {
        {value = 'viewer', label = locale('OxAccounts.roles.viewer')},
        {value = 'contributor', label = locale('OxAccounts.roles.contributor')},
        {value = 'manager', label = locale('OxAccounts.roles.manager')},
        {value = 'owner', label = locale('OxAccounts.roles.owner')}
      }, required = groupInputDialog[5] and true or false}
    }, {options = {allowCancel = false}})
    groupGrades[#groupGrades + 1] = {label = groupGradeInputDialog[1], accountRole = groupGradeInputDialog[2]}
  end
  return {name = groupInputDialog[1], label = groupInputDialog[2], grades = groupGrades, type = groupInputDialog[4], hasAccount = groupInputDialog[5]}
end

-- [ Callbacks ] --

lib.callback.register('pf_management:client:groupCreator', groupCreator)