<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PlayerRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules()
    {
        return [
            'name' => ['required', 'min:2'],
            'team_id' => ['required', 'exists:teams,id'],
        ];
    }

    public function messages()
    {
        return [
            'name.required' => 'The player name field is required.',
            'name.min' => 'The player name must be at least 2 characters.',
            'team_id.required' => 'The team field is required for the player.',
            'team_id.exists' => 'The selected team does not exist.',
        ];
    }
}
