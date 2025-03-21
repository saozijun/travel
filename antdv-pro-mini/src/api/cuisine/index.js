
/**
 * 列表
 * @param {*} data 
 * @returns 
 */
export const  list = (data) => {
  return useGet('/cuisine/page', data)
}

/**
 * 新增编辑
 * @param {*} data 
 * @returns 
 */
export const  save = (data) => {
  return usePost('/cuisine/save', data)
}

/**
 * 删除
 * @param {*} data 
 * @returns 
 */
export const del = (data) => {
  return usePost('/cuisine/delete', data)
}
