import request from '~/utils/request'

export function submitFeedback(data) {
  return request({
    url: '/feedback/submit',
    method: 'post',
    data
  })
}

export function getFeedbacks(params) {
  return request({
    url: '/feedback/list',
    method: 'get',
    params
  })
} 