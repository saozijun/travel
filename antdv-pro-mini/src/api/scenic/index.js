
/**
 * 列表
 * @param {*} data 
 * @returns 
 */
export const  list = (data) => {
  return useGet('/scenic/page', data)
}

/**
 * 新增编辑
 * @param {*} data 
 * @returns 
 */
export const  save = (data) => {
  return usePost('/scenic/save', data)
}

/**
 * 删除
 * @param {*} data 
 * @returns 
 */
export const del = (data) => {
  return usePost('/scenic/delete', data)
}

/**
 * 全部列表
 * @param {*} data 
 * @returns 
 */
export const zdlist = (data) => {
  return useGet('/scenic/list', data)
}
