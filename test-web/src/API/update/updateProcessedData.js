import { computeCurrentDate } from '../../components/DataDetailPage/computePeriod';
import { apiIP } from '../../config';

// 처리육 수정 POST API
export default async function updateProcessedData(
  processedInput, // 처리육 데이터 (수정값)
  processed_data, // 처리육 데이터
  processedMinute, // 처리(딥에이징) 시간
  i, // 처리육 seqno
  meatId, // 이력번호
  userId, // 로그인한 사용자 id
  createdDate, // 생성 날짜
  elapsedHour //경과 시간
) {
  const [yy, mm, dd] = computeCurrentDate();
  //console.log("CHECK",processedInput)
  const dataSet = {
    marbling: parseFloat(processedInput.marbling),
    color: parseFloat(processedInput.color),
    texture: parseFloat(processedInput.texture),
    surfaceMoisture: parseFloat(processedInput.surfaceMoisture),
    overall: parseFloat(processedInput.overall),
  };

  //request body에 보낼 데이터 전처리
  let req = processedInput;
  req = {
    ['meatId']: meatId,
    ['seqno']: i+1,
    ['imgAdded']: false,
    ["filmedAt"] : "2024-07-08T12:12:12",
    ['sensoryData']: dataSet,
  };
  req && delete req['deepaging_data'];
 
  ///meat/add/deep-aging-data로 처리육 수정 데이터 API 전송
  try {
    const response = await fetch(`http://${apiIP}/meat/add/sensory-eval`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(req),
    });
    if (!response.ok) {
      throw new Error(
        'sensory_eval 서버에서 응답 코드가 성공(2xx)이 아닙니다.'
      );
    }
    // 서버에서 받은 JSON 응답 데이터를 parse
    const responseData = await response.json();
    return responseData;
  } catch (err) {
    console.log('error');
    console.error(err);
  }
}
