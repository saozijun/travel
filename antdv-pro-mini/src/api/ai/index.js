/**
 * 发送消息到AI旅游专家
 * @param {*} data 
 * @returns 
 */
export const sendToTravelExpert = (data) => {
  return usePost('/ai/travelExpert', data, {
    headers: {
      'Content-Type': 'text/plain'
    }
  })
} 