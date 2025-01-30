import axios from "axios";
import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";
import {getGreeting} from "/opt/nodejs/common-layer";

export const deleteEntitiesHandler = async (event:APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
  return {
    statusCode: 200,
    body: JSON.stringify({
        message: getGreeting("delete-entities function")
    })
};
};